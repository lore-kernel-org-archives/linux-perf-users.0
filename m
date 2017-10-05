From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf callchain: Compare dsos (as well) for CCKEY_FUNCTION
Date: Thu, 5 Oct 2017 13:13:55 +0900
Message-ID: <20171005041355.GB1584@danjae.aot.lge.com>
References: <20171004130834.GD23759@krava>
 <20171005035021.6679-1-ravi.bangoria@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36373 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdJEEQL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Oct 2017 00:16:11 -0400
Content-Disposition: inline
In-Reply-To: <20171005035021.6679-1-ravi.bangoria@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: pozdneyev@gmail.com, acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com, ak@linux.intel.com, kjlx@templeofstupid.com, milian.wolff@kdab.com, zhangmengting@huawei.com, kernel-team@lge.com

Hi,

On Thu, Oct 05, 2017 at 09:20:21AM +0530, Ravi Bangoria wrote:
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
> index be09d77..6d7f645 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -685,6 +685,9 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
>  {
>  	struct symbol *sym = node->sym;
>  	u64 left, right;
> +	struct dso *left_dso = NULL;
> +	struct dso *right_dso = NULL;
> +
>  
>  	if (callchain_param.key == CCKEY_SRCLINE) {
>  		enum match_result match = match_chain_srcline(node, cnode);
> @@ -696,12 +699,16 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
>  	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
>  		left = cnode->ms.sym->start;
>  		right = sym->start;
> +		if (cnode->ms.map)
> +			left_dso = cnode->ms.map->dso;
> +		if (node->map)
> +			right_dso = node->map->dso;

AFAIK having a symbol guarantees having a map too.  So it could simply
be:

		left_dso = cnode->ms.map->dso;
		right_dso = node->map->dso;

Thanks,
Namhyung


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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
