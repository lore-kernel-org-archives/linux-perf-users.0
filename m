Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6B2376E1
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592264; cv=none; b=Ls7TuN5lx+KKZfSvCJNgQ93k4QkZOWTzrhubss8fFhgaDeicaGJaRRr65ruc/mXrCMHCVBdnTwq15WUNIpdZNsXNyIgXrcPZisUINNA8lSCANbM0qfhdwKco/YmbfU61UWr0wkIRmBvnQsNupUW2VPyMJBlwQQqtow9KCPMi7NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592264; c=relaxed/simple;
	bh=EWrgD18r2nfU1tBqbRK5IiJug7+Vse8FsJKY0eEvPCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbQjRDptNeliA54cIQlOIzCElF/Vz1HOEXJcLlhNB8geEILKXTmNInfmyoquWrtX9oRx6nMJJeJ/6EGSGMpIuOUSKlnbsPQxRO7ZgfEI75yOhH2FE+iNKw/sFABdRMNU8ggLpfkGwTi11a8aV4cf0PTFecmv8mlYV9iDX28i7Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdpBNLJt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdpBNLJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743592261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgTSlcWUxY8a6JwJYyv7GJqNtqyp4QlKElc3qaVOgZs=;
	b=RdpBNLJtMz+CqExgkcU/O4oEhRp8xvPjA0Q8RFLy+Bo9sdMaHk6u7U4GDlK04jc6jGTR2D
	n3lGYzyPw/mDlvqAKGeajmbE52H4V9juzCe+/nmAKaSfhi2kwacMki4Mvg7IspGNt1jHWJ
	Lf7zvfRUgJhKgaFRIckxNjLlvHsB7h4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-xDKcHiZ4NxqXSrHBPqvjqA-1; Wed,
 02 Apr 2025 07:10:56 -0400
X-MC-Unique: xDKcHiZ4NxqXSrHBPqvjqA-1
X-Mimecast-MFC-AGG-ID: xDKcHiZ4NxqXSrHBPqvjqA_1743592253
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70F521809CA6;
	Wed,  2 Apr 2025 11:10:51 +0000 (UTC)
Received: from f39 (unknown [10.45.225.130])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 738421828A80;
	Wed,  2 Apr 2025 11:10:25 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:10:22 +0200
From: Eder Zulian <ezulian@redhat.com>
To: Ian Rogers <irogers@google.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>,
	Ben Gainey <ben.gainey@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>,
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Howard Chu <howardchu95@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jann Horn <jannh@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Yang Jihong <yangjihong@bytedance.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Hao Ge <gehao@kylinos.cn>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Casey Chen <cachen@purestorage.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Andrew Kreimer <algonell@gmail.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Zixian Cai <fzczx123@gmail.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 04/48] x86/insn: Silence -Wshorten-64-to-32 warnings
Message-ID: <Z-0bHg4aX5uX33CU@f39>
References: <20250401182347.3422199-1-irogers@google.com>
 <20250401182347.3422199-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401182347.3422199-5-irogers@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello, apologies if I'm missing something, but

On Tue, Apr 01, 2025 at 11:23:02AM -0700, Ian Rogers wrote:
> The clang warning -Wshorten-64-to-32 can be useful to catch
> inadvertent truncation. In some instances this truncation can lead to
> changing the sign of a result, for example, truncation to return an
> int to fit a sort routine. Silence the warning by making the implicit
> truncation explicit.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/arch/x86/lib/insn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> index e91d4c4e1c16..5fa8697498fe 100644
> --- a/tools/arch/x86/lib/insn.c
> +++ b/tools/arch/x86/lib/insn.c
> @@ -92,7 +92,7 @@ static int __insn_get_emulate_prefix(struct insn *insn,
>  			goto err_out;
>  	}
>  
> -	insn->emulate_prefix_size = len;
> +	insn->emulate_prefix_size = (int)len;

wouldn't something like 
+ insn->emulate_prefix_size = !!len;
be preferable in this case?

Apparently the 'insn->emulate_prefix_size' is only used in
'insn_has_emulate_prefix()'. Perhaps both the flag 'emulate_prefix_size'
(currently an 'int') and the 'insn_has_emulate_prefix()' function return
type could be changed to boolean?

>  	insn->next_byte += len;

My knowledge of this part of the code is limited, however IMO it seems
strange to have the 'emulate_prefix_size' flag affected implictly or
explicitly by truncation and the pointer 'insn->next_byte' advanced
regardless.

>  
>  	return 1;
> -- 
> 2.49.0.504.g3bcea36a83-goog
> 

