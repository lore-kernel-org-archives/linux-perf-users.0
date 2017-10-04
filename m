From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC] perf callchain: Compare dsos (as well) for CCKEY_FUNCTION
Date: Wed, 4 Oct 2017 15:08:34 +0200
Message-ID: <20171004130834.GD23759@krava>
References: <CAE3E0fDuYbhSj_EESFh2OKzBUQS=oGKWm3+H7XJARi=m7CLxqQ@mail.gmail.com>
 <20171004061308.1246-1-ravi.bangoria@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbdJDNIi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Oct 2017 09:08:38 -0400
Content-Disposition: inline
In-Reply-To: <20171004061308.1246-1-ravi.bangoria@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: pozdneyev@gmail.com, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kjlx@templeofstupid.com, milian.wolff@kdab.com, zhangmengting@huawei.com

On Wed, Oct 04, 2017 at 11:43:08AM +0530, Ravi Bangoria wrote:
> Two functions from different binaries can have same start
> address. Thus, comparing only start address in match_chain()
> leads to inconsistent callchains. Fix this by adding a check
> for dsos as well.
> 
> Ex, https://www.spinics.net/lists/linux-perf-users/msg04067.html
> 
> Reported-by: Alexander Pozdneev <pozdneyev@gmail.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  tools/perf/util/callchain.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 510b513..6d5a483 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -678,6 +678,9 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
>  {
>  	struct symbol *sym = node->sym;
>  	u64 left, right;
> +	struct dso *left_dso = NULL;
> +	struct dso *right_dso = NULL;
> +
>  
>  	if (callchain_param.key == CCKEY_SRCLINE) {
>  		enum match_result match = match_chain_srcline(node, cnode);
> @@ -689,12 +692,16 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
>  	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
>  		left = cnode->ms.sym->start;
>  		right = sym->start;
> +		if (cnode->ms.map && node->map) {
> +			left_dso = cnode->ms.map->dso;
> +			right_dso = node->map->dso;

makes sense.. but why not to get those maps separately?

	if (cnode->ms.map)
		left_dso = cnode->ms.map->dso;
	if (node->map) {
		right_dso = node->map->dso;

I'd think that if one is missing, it's most likely different
map/dso and you want to fail the == check

jirka

> +		}
>  	} else {
>  		left = cnode->ip;
>  		right = node->ip;
>  	}
>  
> -	if (left == right) {
> +	if (left == right && left_dso == right_dso) {
>  		if (node->branch) {
>  			cnode->branch_count++;
>  
> -- 
> 1.8.3.1
> 
