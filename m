Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A694328468E;
	Wed, 30 Apr 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746044825; cv=none; b=I41u1Vr2FjQaG0CaMTvS9iZBebBVr89L1lk3eSBH9at/MNV7ZzUe7pOLmP3jK9h9GsqQJzrTqLuN6Yb1Pcjk1zKBXSlNO+TdDme4JdMHf+Qyz8lSClhdN5nRAcVFvLSuT2Ow6dvR58fI4KpLZ381Ji3oKhMpG9r2zLvyLY7haZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746044825; c=relaxed/simple;
	bh=igmaqu04BoyuJHWkaAvyxTOcNQ1SWurIf7nrVvUlC1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bGCtGlmtvzzbhbaLSp9np/6xRrjr1+NRBAUxvva4frdDeHkYGB2gaGhNmc7E3S28JddCle4OSaQ6J9Y8OiFyfL4/AruvsqvI7OrOgDNYAkY+oy0jj4dL7FmzbBxa4nOqSO7tIHa1D/idli51jC1CYd5voI+7NLnhzUq6Nb576GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=pYwnNS01; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="pYwnNS01"
Received: from localhost (ip-109-42-178-232.web.vodafone.de [109.42.178.232])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 53UKNBpu018771
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 30 Apr 2025 22:23:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1746044598; bh=igmaqu04BoyuJHWkaAvyxTOcNQ1SWurIf7nrVvUlC1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=pYwnNS01YzJREwB05U6HGCvRRm1UsaZTUT/DDa2uBO6+yelbd7/r8G3614CzGUMKt
	 y5KC8GeaNcCAK7lHMmK1VBtdpbMG7kMUyLCPjVeJA7zHAKh7KoBl95IEZ4D/ryZx5W
	 7EOXcOQ+gXB6Cw1KNYLf8K0kAXgiGcFom76jNhgc=
From: Dirk Gouders <dirk@gouders.net>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
 <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang
 <kan.liang@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus
 Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr
 Bueso <dave@stgolabs.net>,
        =?utf-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>,
        John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@linaro.org>,
        Mike Leach
 <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
        Yicong Yang
 <yangyicong@hisilicon.com>,
        Jonathan Cameron
 <jonathan.cameron@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>,
        Ben Gainey <ben.gainey@arm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain
 <kjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Eder Zulian
 <ezulian@redhat.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Kuan-Wei
 Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>,
        Brian Geffon
 <bgeffon@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Howard Chu
 <howardchu95@gmail.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Colin
 Ian King <colin.i.king@gmail.com>,
        Dominique Martinet
 <asmadeus@codewreck.org>,
        Jann Horn <jannh@google.com>, Masahiro Yamada
 <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Yang Jihong
 <yangjihong@bytedance.com>,
        Dmitry Vyukov <dvyukov@google.com>, Andi
 Kleen <ak@linux.intel.com>,
        Graham Woodward <graham.woodward@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Anshuman Khandual
 <anshuman.khandual@arm.com>,
        Zhongqiu Han <quic_zhonhan@quicinc.com>, Hao Ge <gehao@kylinos.cn>,
        Tengda Wu <wutengda@huaweicloud.com>,
        Gabriele Monaco <gmonaco@redhat.com>,
        Chun-Tse Shao <ctshao@google.com>, Casey Chen <cachen@purestorage.com>,
        "Dr. David Alan Gilbert"
 <linux@treblig.org>,
        Li Huafei <lihuafei1@huawei.com>,
        "Steinar H.
 Gunderson" <sesse@google.com>,
        Levi Yun <yeoreum.yun@arm.com>, Weilin
 Wang <weilin.wang@intel.com>,
        Thomas Falcon <thomas.falcon@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Andrew Kreimer
 <algonell@gmail.com>,
        =?utf-8?Q?Krzysztof_=C5=81opatowski?=
 <krzysztof.m.lopatowski@gmail.com>,
        Christophe Leroy
 <christophe.leroy@csgroup.eu>,
        Jean-Philippe Romain
 <jean-philippe.romain@foss.st.com>,
        Junhao He <hejunhao3@huawei.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Xu Yang
 <xu.yang_2@nxp.com>,
        Steve Clevenger
 <scclevenger@os.amperecomputing.com>,
        Zixian Cai <fzczx123@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yujie Liu
 <yujie.liu@intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 04/47] perf bench: Silence -Wshorten-64-to-32 warnings
In-Reply-To: <20250430175036.184610-5-irogers@google.com> (Ian Rogers's
	message of "Wed, 30 Apr 2025 10:49:52 -0700")
References: <20250430175036.184610-1-irogers@google.com>
	<20250430175036.184610-5-irogers@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 30 Apr 2025 22:23:06 +0200
Message-ID: <gho6wdh00l.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Ian,

considering so many eyes looking at this, I am probably wrong.

So, this is only a "gauge reply" to see if it's worth I really read
through all the commits ;-)

Ian Rogers <irogers@google.com> writes:

[SNIP]

> diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
> index 70139036d68f..b847213fd616 100644
> --- a/tools/perf/bench/sched-pipe.c
> +++ b/tools/perf/bench/sched-pipe.c
> @@ -102,7 +102,8 @@ static const char * const bench_sched_pipe_usage[] = {
>  static int enter_cgroup(int nr)
>  {
>  	char buf[32];
> -	int fd, len, ret;
> +	int fd;
> +	ssize_t ret, len;
>  	int saved_errno;
>  	struct cgroup *cgrp;
>  	pid_t pid;
> @@ -118,7 +119,7 @@ static int enter_cgroup(int nr)
>  	cgrp = cgrps[nr];
>  
>  	if (threaded)
> -		pid = syscall(__NR_gettid);
> +		pid = (pid_t)syscall(__NR_gettid);
>  	else
>  		pid = getpid();
>  
> @@ -172,23 +173,25 @@ static void exit_cgroup(int nr)
>  
>  static inline int read_pipe(struct thread_data *td)
>  {
> -	int ret, m;
> +	ssize_t ret;
> +	int m;
>  retry:
>  	if (nonblocking) {
>  		ret = epoll_wait(td->epoll_fd, &td->epoll_ev, 1, -1);

The epoll_wait(), I know of, returns an int and not ssize_t.

That shouldn't show up, because it doesn't cause real problems...


Best regards,

Dirk


