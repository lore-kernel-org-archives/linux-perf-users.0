From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2] perf callchain: Compare dsos (as well) for
 CCKEY_FUNCTION
Date: Thu, 5 Oct 2017 11:26:43 +0200
Message-ID: <20171005092643.GA7975@krava>
References: <20171005041355.GB1584@danjae.aot.lge.com>
 <20171005091234.5874-1-ravi.bangoria@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171005091234.5874-1-ravi.bangoria@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: pozdneyev@gmail.com, acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com, ak@linux.intel.com, kjlx@templeofstupid.com, milian.wolff@kdab.com, zhangmengting@huawei.com
List-Id: linux-perf-users.vger.kernel.org

On Thu, Oct 05, 2017 at 02:42:34PM +0530, Ravi Bangoria wrote:
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
> Changes in v2:
>   - Remove unnecessary checks for 'map'

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  tools/perf/util/callchain.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index be09d77..a971caf 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -685,6 +685,8 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
>  {
>  	struct symbol *sym = node->sym;
>  	u64 left, right;
> +	struct dso *left_dso = NULL;
> +	struct dso *right_dso = NULL;
>  
>  	if (callchain_param.key == CCKEY_SRCLINE) {
>  		enum match_result match = match_chain_srcline(node, cnode);
> @@ -696,12 +698,14 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
>  	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
>  		left = cnode->ms.sym->start;
>  		right = sym->start;
> +		left_dso = cnode->ms.map->dso;
> +		right_dso = node->map->dso;
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
