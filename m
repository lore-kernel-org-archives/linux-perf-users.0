From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v6 1/6] perf report: properly handle branch count in
 match_chain
Date: Fri, 20 Oct 2017 10:39:35 -0300
Message-ID: <20171020133935.GD30002@kernel.org>
References: <20171018185350.14893-1-milian.wolff@kdab.com>
 <20171019150108.GA24104@danjae.aot.lge.com>
 <4075632.NPQJP4Tzi9@agathebauer>
 <1542636.JzONsm6D9Z@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542636.JzONsm6D9Z@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, jolsa@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, kernel-team@lge.com
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Oct 20, 2017 at 01:38:23PM +0200, Milian Wolff escreveu:
> On Freitag, 20. Oktober 2017 12:21:35 CEST Milian Wolff wrote:
> > On Donnerstag, 19. Oktober 2017 17:01:08 CEST Namhyung Kim wrote:
> > > Hi Andi,
> > > 
> > > On Thu, Oct 19, 2017 at 06:55:19AM -0700, Andi Kleen wrote:
> > > > On Thu, Oct 19, 2017 at 12:59:14PM +0200, Milian Wolff wrote:
> > > > > On Donnerstag, 19. Oktober 2017 00:41:04 CEST Andi Kleen wrote:
> > > > > > Milian Wolff <milian.wolff@kdab.com> writes:
> > > > > > > +static enum match_result match_address_dso(struct dso *left_dso,
> > > > > > > u64
> > > > > > > left_ip, +					   struct dso *right_dso, u64 right_ip)
> > > > > > > +{
> > > > > > > +	if (left_dso == right_dso && left_ip == right_ip)
> > > > > > > +		return MATCH_EQ;
> > > > > > > +	else if (left_ip < right_ip)
> > > > > > > +		return MATCH_LT;
> > > > > > > +	else
> > > > > > > +		return MATCH_GT;
> > > > > > > +}
> > > > > > 
> > > > > > So why does only the first case check the dso? Does it not matter
> > > > > > for the others?
> > > > > > 
> > > > > > Either should be checked by none or by all.
> > > > > 
> > > > > I don't see why it should be checked. It is only required to prevent
> > > > > two
> > > > > addresses to be considered equal while they are not. So only the one
> > > > > check is required, otherwise we return either LT or GT.
> > > > 
> > > > When the comparison is always in the same process (which I think
> > > > is not the case) just checking the addresses is sufficient. If they are
> > > > not then you always need to check the DSO and only compare inside the
> > > > same DSO.
> > > 
> > > As far as I know, the node->ip is a relative address (inside a DSO).
> > > So it should compare the dso as well even in the same process.
> > 
> > Sorry guys, I seem to be slow at understanding your review comments.
> > 
> > match_address_dso should impose a sort order on two relative addresses. The
> > order should ensure that relative addresses in a different DSO are not
> > considered equal. But if the DSOs are different, it doesn't matter whether
> > we return LT or GT - or?
> > 
> > Put differently, how would you write this function to take care of the DSO
> > in the other two branches? I.e. what to return if the DSOs are different -
> > a MATCH_ERROR?
> 
> Thinking a bit more about this. Are you guys maybe hinting at my 
> implementation breaking the strict ordering rules (is that the right word?). 
> I.e. a < b && b > a iff a == b ? Potentially my implementation would break 
> this assumption when the relative IPs are the same, but the DSO is different.
> 
> So is this what you want:
> 
> +static enum match_result match_address_dso(struct dso *left_dso, u64
>  left_ip, +                                         struct dso *right_dso, u64 
> right_ip)
>  +{
>  +       if (left_dso == right_dso && left_ip == right_ip)
>  +               return MATCH_EQ;
>  +       else if (left_dso < right_dso || left_ip < right_ip)
>  +               return MATCH_LT;
>  +       else
>  +               return MATCH_GT;
>  +}

Why not do all in terms of absolute addresses? Comparing relative
addresses seems nonsensical anyway. Perhaps something like the patch
below, and note that cnode->ip and node->ip already already are absolute
addresses.

Ravi?

- Arnaldo

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 35a920f09503..1ac3f4a5afab 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -671,8 +671,6 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 {
 	struct symbol *sym = node->sym;
 	u64 left, right;
-	struct dso *left_dso = NULL;
-	struct dso *right_dso = NULL;
 
 	if (callchain_param.key == CCKEY_SRCLINE) {
 		enum match_result match = match_chain_strings(cnode->srcline,
@@ -698,16 +696,14 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			return match_chain_strings(cnode->ms.sym->name,
 						   node->sym->name);
 
-		left = cnode->ms.sym->start;
-		right = sym->start;
-		left_dso = cnode->ms.map->dso;
-		right_dso = node->map->dso;
+		left = cnode->ms.map->unmap_ip(cnode->ms.map, cnode->ms.sym->start);
+		right = node->map->unmap_ip(node->map, sym->start);
 	} else {
 		left = cnode->ip;
 		right = node->ip;
 	}
 
-	if (left == right && left_dso == right_dso) {
+	if (left == right) {
 		if (node->branch) {
 			cnode->branch_count++;
 
