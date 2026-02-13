Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4B757EA;
	Fri, 13 Feb 2026 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975316; cv=none; b=qz3GMfDD/HYI37koJTSjITLVR2R/QKdM4hSyT6WdYAWVcdZHlhmRLcECeZf7CVUlKZSl+4L30AZoL7U81Q7wsouBqdLYxuWb046U8G7WR0lJe5tNKfcY0jQxTuh6nXEvrEchb+uiEMZFzi9jA3/0dkspC3uJjAavSTe4fXCOhpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975316; c=relaxed/simple;
	bh=i0Ng+SbrWeasep0IQMM6CzezEM3YdWRf5Mij1pC7QjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdK5KDcIq/zNhwMKfoVuBrLlWR7CUXhnB7YMAsG6y6o44bM4MlrlWqXquI12CrDedUhcucKbZXyWcVwWtGpMMODDaq4hM5edjeg+O23dNnXnqbMHN6TuUX6R0wC7/L9vLEbQHsJVUi5MoLqA5f6+zI3Uk+IPoGykkb8E6fU3GK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JWE3tfiz; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JWE3tfiz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=KtHVQz5g9cI/EfmzjSC8+uHBUlUdIvfIpOSkcCQKRvc=;
	b=JWE3tfizzVfElNWskr+9GhVwLoklLksGLYDfoPmrNm70gWfPCRfJh15vNh4ASE
	t2l1MFdSEnFLU033GpPKytoXTH+jfSOwLuRhqNv8CLNnZUh95mV+8gWJLej2riIZ
	EpRmyQ94O2U/+N3tDHT8cCg9ZNlzWsQLFXTYFppWDUnsQ=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3uvYU8I5pgKVEPA--.17197S2;
	Fri, 13 Feb 2026 17:34:14 +0800 (CST)
Date: Fri, 13 Feb 2026 17:34:12 +0800
From: Chingbin Li <liqb365@163.com>
To: Ian Rogers <irogers@google.com>
Cc: james.clark@linaro.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf cpumap: Fix argument x range [] exceeds maximum
 object size
Message-ID: <xz46vvcv5u5hpxbvwhvxsnkmgqgadyhoqyponmrs673sklkmap@7voxutqxozy2>
References: <20260212025127.841090-1-liqb365@163.com>
 <CAP-5=fWqP43QH0=+Cx+s=GM0uwJ9Lzt9Zw2Xw-NxOP-tXkoOJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWqP43QH0=+Cx+s=GM0uwJ9Lzt9Zw2Xw-NxOP-tXkoOJQ@mail.gmail.com>
X-CM-TRANSID:PigvCgD3uvYU8I5pgKVEPA--.17197S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF13GF4kJr1UWw1xtF1xuFg_yoWrZw4kpF
	43Cw17Gr95Jr1rG34UJr18tr1jqr12q3yjv34rK3yrAr1DAa4kJF40yF18Kry7urWv9F1U
	trsrtFn8JFy7Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYiihUUUUU=
X-CM-SenderInfo: xoltujiwv6il2tof0z/xtbC5RY-r2mO8BZxZgAA31

Hi, Ian:

-------------------------------------------------------------------------------------
About whether this issue is unique to the RISC-V architecture, my test result is:

Machine / OS / Whether it occurred
AMD9950x / Ubuntu 24.04 / No
qemu-system-x86_64 / Ubuntu 24.04 / No
qemu-system-riscv64 / Ubuntu 24.04 / Yes

So I haven't observed the same issue on computers other than riscv64 yet.

-------------------------------------------------------------------------------------
I think there are several ways to fix this issue.

a. Add the volatile qualifier to the tmp_len variable.
b. Use #pragma to ignore the warning.
c. Change the type of the tmp_len variable to size_t.
   However, After trying it out, changing the type alone does not fix this issue;
   a numerical range check also needs to be added.

These methods seem to have some shortcomings.

My current thought is that adding a numerical range check seems to be a more appropriate solution.
It can effectively resolve the issue even without changing the type of tmp_len.

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 4160e7d2e120f..e0407796fcd9d 100644
--- a/tools/lib/perf/cpumap.c
@@ -413,6 +413,8 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, struct p
+++ b/tools/lib/perf/cpumap.c
@@ -413,6 +413,8 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
        int tmp_len;
        int i, j, k;
        struct perf_cpu_map *merged;
+       int orig_nr = __perf_cpu_map__nr(*orig);
+       int other_nr = __perf_cpu_map__nr(other);
 
        if (perf_cpu_map__is_subset(*orig, other))
                return 0;
@@ -422,7 +424,11 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
                return 0;
        }
 
-       tmp_len = __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(other);
+       if (orig_nr < 0 || other_nr < 0 || orig_nr + other_nr > INT_MAX) {
+               return -EINVAL;
+       }
+       tmp_len = orig_nr + other_nr;
        tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
        if (!tmp_cpus)
                return -ENOMEM;

This method has good compatibility while keeping `tmp_len` and other variables used for comparison the same type.
If you agree with this idea, I will submit it as a v2 patch.

-------------------------------------------------------------------------------------
I agree that the nr field type should be changed to size_t.
I tried making the modification. It seems that after this modification,
there will be comparisons between `int` and `size_t` variables,
which will require some type casting.

Thanks,
Chingbin

On Thu, Feb 12, 2026 at 10:24:12AM -0800, Ian Rogers wrote:
> On Wed, Feb 11, 2026 at 6:54 PM Chingbin Li <liqb365@163.com> wrote:
> >
> > On RISC-V 64-bit Ubuntu 24.04 Server (Running on QEMU), the following error might occur when compiling perf:
> >
> > cpumap.c: In function ‘perf_cpu_map__merge’:
> > cpumap.c:429:20: error: argument 1 range [18446744069414584320, 18446744073709551614] exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
> >   429 |         tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> >       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > In file included from cpumap.c:4:
> > /usr/include/stdlib.h:672:14: note: in a call to allocation function ‘malloc’ declared here
> >   672 | extern void *malloc (size_t __size) __THROW __attribute_malloc__
> >       |              ^~~~~~
> > cc1: all warnings being treated as errors
> >
> > We use the volatile qualifier to prevent unnecessary errors caused by the compiler's constant propagation.
> 
> This shouldn't be a RISC-V specific problem.Does changing tmp_len to a
> size_t fix it? __perf_cpu_map__nr and  perf_cpu_map__nr should
> probably both return a size_t too, and the type of nr in struct
> perf_cpu_map should not be signed.
> 
> Thanks,
> Ian
> 
> > ---
> >  tools/lib/perf/cpumap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > index 4160e7d2e120..ccf473994111 100644
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -410,7 +410,7 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
> >  int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
> >  {
> >         struct perf_cpu *tmp_cpus;
> > -       int tmp_len;
> > +       volatile int tmp_len;
> >         int i, j, k;
> >         struct perf_cpu_map *merged;
> >
> > --
> > 2.43.0
> >

