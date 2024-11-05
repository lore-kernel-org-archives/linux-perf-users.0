Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA537DA6F;
	Tue,  5 Nov 2024 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827095; cv=none; b=awmt+17BvxXhgnENrWxbbNLUz62jsQqkQp1Q/1omXP3vjlZaPNmKTY3PJF/xnLR6pCYLPL3BUIik5/JFLefrdvvoW3rxxbNJ0m3nHMsM5tskTbm3kXk8eTlFHY4r7BRkH2GfsolykJ9mWTpa1WIvwnpJK+f8eRO4aTYq8kj9x2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827095; c=relaxed/simple;
	bh=LeFODbmvz6aSdR+bp9Mmfb1Yl/faHQ2U6LrOy8LLe3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT+b7sEPTriHxYYEtuDXKiqdovV9VbzwlUFrribNCsDDh+RrOkNos+DLQebgT9KBVvU8co/cUuwEmkf86p0NhFt6NCg7JcXzKQTcydfwIIRZJdi+imOl3T6UEGnEKM3HKZWhYtsnvpY91XGEBZuyXnFwtE0J2Pl2u7A9fOf7zfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOCG5Oz5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOCG5Oz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7233EC4CECF;
	Tue,  5 Nov 2024 17:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730827095;
	bh=LeFODbmvz6aSdR+bp9Mmfb1Yl/faHQ2U6LrOy8LLe3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOCG5Oz5/PqdllpuGibUVneePqvQ6rfe01qJVDBI/nBRIhHBfLoyBjZ1B/yIOolhK
	 WhQbYxZHqc+pEJi9m5MbYyKO4z9OS8pIsjFhX0DM2zj+Xm6yj9Cnrpcudne7IYKuOS
	 d3HXuysSocftBZH5mi8YWxbhuZD7JW8fPL5V42NhVWDA9JKpxfc45PPh2feTd4PKMW
	 AQN0NecSYSOQN3cESlfX6+oqfrCjiuxHk8nTv6tsK5KChNB9UGdV8VcBKpi2JKjzO7
	 hsedwg/J0vuilzSTJJFiV/J85YzNxBEFEAIkmND6KLL3y1Hn9ht+f7B3Sas4TNJk8o
	 hPAcp6x5gIDJA==
Date: Tue, 5 Nov 2024 14:18:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	James Clark <james.clark@linaro.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
	Ben Gainey <ben.gainey@arm.com>,
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>,
	Paran Lee <p4ranlee@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/6] tool api fs: Correctly encode errno for
 read/write open failures
Message-ID: <ZypTU7D3GUZ1APPQ@x1>
References: <20241102165400.75785-1-irogers@google.com>
 <20241102165400.75785-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102165400.75785-2-irogers@google.com>

On Sat, Nov 02, 2024 at 09:53:55AM -0700, Ian Rogers wrote:
> Switch from returning -1 to -errno so that callers can determine types
> of failure.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/fs/fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
> index 337fde770e45..edec23406dbc 100644
> --- a/tools/lib/api/fs/fs.c
> +++ b/tools/lib/api/fs/fs.c
> @@ -296,7 +296,7 @@ int filename__read_int(const char *filename, int *value)
>  	int fd = open(filename, O_RDONLY), err = -1;
>  
>  	if (fd < 0)
> -		return -1;
> +		return -errno;
>  
>  	if (read(fd, line, sizeof(line)) > 0) {
>  		*value = atoi(line);
> @@ -314,7 +314,7 @@ static int filename__read_ull_base(const char *filename,
>  	int fd = open(filename, O_RDONLY), err = -1;
>  
>  	if (fd < 0)
> -		return -1;
> +		return -errno;
>  
>  	if (read(fd, line, sizeof(line)) > 0) {
>  		*value = strtoull(line, NULL, base);
> @@ -372,7 +372,7 @@ int filename__write_int(const char *filename, int value)
>  	char buf[64];
>  
>  	if (fd < 0)
> -		return err;
> +		return -errno;
>  
>  	sprintf(buf, "%d", value);
>  	if (write(fd, buf, sizeof(buf)) == sizeof(buf))
> -- 
> 2.47.0.199.ga7371fff76-goog
