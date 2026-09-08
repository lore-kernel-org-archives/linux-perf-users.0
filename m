Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA183E1693;
	Tue,  8 Sep 2026 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901044; cv=none; b=u5qu77xgJXA4E+z+9/pvDQNQRJPHDE31oxFl718VI4hl7DsssMGbM+oGVNrbyWVwOD/2dJF9MoVgXbuetgLtdvdje1Wb3aB7FRcsZNaZdNn1YRO/yUfL48QKI0ABz/3n3tfpicjKtAmuYXiYc9qOvf/RtYx194+5LilovxbGIHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901044; c=relaxed/simple;
	bh=HrSPFsKp0wFlpni6/QiEaoWOU6liqmNhb4pqx4sHtv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7IntH3M/+vLbl0hoAnZiSssg4dV7agxkmGTznBNXZxwUb++cH65kLEd2pDSnfHldg3RmV+2U2YYU4RfpZmGFEA9gdE/XNkicih8lUoGjmjn7detH6+xAj+8Sa1yXCPj6NlLqciK/u9V2YW6/K68VrDhuApEEr2nv8CXlWCFDlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3aqR8NQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3aqR8NQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F161F00A3D;
	Tue,  8 Sep 2026 20:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788901043;
	bh=oJaNyP8BseQVqY/Z8wTo5dWTY+9PmajgXbAhOiPKXqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X3aqR8NQE5ODLSxSR3PBu95Y/dNOJJHcIoKcTcAivtmPAINhnaEcxuAizn/w1jXoa
	 HHhqifnnadE2vKzpoC7NlPK7AOTvVn7uD142932khKWa1E2zb0H6dVcA+l8tBvSCI/
	 MNEtBqgRBXovhGHTiCe2HFayw0kmm+/vrWcb/YOI4dLCdCw0HFwB4EZWXKpbCxIDDK
	 gauC7DtNTA6k1IPCtmWYMsA7ZrqcNDO5k2tgNlXSDz4fyQHFQB4VS+11wOAmHyIRVE
	 2vXn69uwaPt1T+HtjZMKBqLrYTxji3nb69gPX1OQgKYthJw1DSERWQgqW/lmiiKPTJ
	 AqRDjD2QfMnaQ==
Date: Tue, 8 Sep 2026 17:57:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: liujing <liujing@cmss.chinamobile.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf python: Fix redundant self-assignment in
 get_argument_count()
Message-ID: <aqB2sBQqZj_K5rQ4@x2>
References: <20260903081350.4676-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903081350.4676-1-liujing@cmss.chinamobile.com>

On Thu, Sep 03, 2026 at 04:13:50PM +0800, liujing wrote:
> From: Liu Jing <liujing@cmss.chinamobile.com>
> 
> In get_argument_count(), the variable code_obj is assigned to itself
> before being assigned the result of PyObject_GetAttrString(). This is
> a redundant self-assignment that appears to be a typo.
> 
> Fix it by removing the redundant self-assignment.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
 
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
> ---
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -165,7 +165,7 @@
>  {
>  	int arg_count = 0;
>  
> -	PyObject *code_obj = code_obj = PyObject_GetAttrString(handler, "__code__");
> +	PyObject *code_obj = PyObject_GetAttrString(handler, "__code__");
>  	PyErr_Clear();
>  	if (code_obj) {
>  		PyObject *arg_count_obj = PyObject_GetAttrString(code_obj,
> 
> 
> 
