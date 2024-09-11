Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277A185B7F;
	Wed, 11 Sep 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064811; cv=none; b=aen1QCCw8BXtSYbmeMvixMBNQOhajGtf99WW2ene7PdnIdJj6qdPzPhfbnSU2u/StGO6tHSSBt3IcSuMGdxuolS1R31e1LH3pOuWB2sp7eZxpr0aM3zhyFOdQ0XFQRlxZA74QXxk4bgl2+gVADcAW6mxYOHjAjDsLBB5uSxWh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064811; c=relaxed/simple;
	bh=GyOydcKwxKTqPcJaT9VvpHocCXPnTdPdYhYuSdMs/WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkkU/D0Dh9WFKaCzBXL4Z5W3QiPujub7mKXyF975YqzdByYgL83OqJO5cqYdrD8jaOlV8XWH6BAIw6s4lyFvi9teFJs0/30L6abmK/fpRJT7SCHv4ufmk2nC+hBJS09u8PO7h44p4GfGurhx2v/C8Avvn6IQ9tAcMDnuF1jC/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX23i1SB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX23i1SB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A1DC4CEC0;
	Wed, 11 Sep 2024 14:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726064811;
	bh=GyOydcKwxKTqPcJaT9VvpHocCXPnTdPdYhYuSdMs/WQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fX23i1SB5C/j0YTxs1bA9zAMI/+DGjN1dbz7WQDSLeDvjXMJDHhtqMGj9Kgfto0tn
	 o7Ba89sCX2BVYMVvR6hrvXJiK0JeY8aDOpnIMYlYkz46+Y4jBc/yEJUDEfOmvbmsMN
	 y5huQveC4K9noRQO0DwCLC9VmpT/ZkQv3CjQmUJpUrCQDcmser4X7e1Zv5GHztcTvQ
	 toswBOSKji+Bb8dQi3QRqgdKsJ26ctBU5iTsHiD9tA5WhXFwkJzXHcXzz84nGQHGjv
	 JltP6g/0WLnfpq7jjcmdlcnUCL+HjlR53N1ZsdaaLj26zouu0QXVIhHjopC5YvpKmp
	 l+KpUCk2SrP1w==
Date: Wed, 11 Sep 2024 11:26:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Junhao He <hejunhao3@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 01/15] perf list: Avoid potential out of bounds memory
 read
Message-ID: <ZuGop61JahKH-UFi@x1>
References: <20240907050830.6752-1-irogers@google.com>
 <20240907050830.6752-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907050830.6752-2-irogers@google.com>

On Fri, Sep 06, 2024 at 10:08:16PM -0700, Ian Rogers wrote:
> If a desc string is 0 length then -1 will be out of bounds, add a
> check.

Cherry picked this one.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 82cb4b1010aa..65b8cba324be 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -173,7 +173,7 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
>  		if (pmu_name && strcmp(pmu_name, "default_core")) {
>  			desc_len = strlen(desc);
>  			desc_len = asprintf(&desc_with_unit,
> -					    desc[desc_len - 1] != '.'
> +					    desc_len > 0 && desc[desc_len - 1] != '.'
>  					      ? "%s. Unit: %s" : "%s Unit: %s",
>  					    desc, pmu_name);
>  		}
> -- 
> 2.46.0.469.g59c65b2a67-goog
