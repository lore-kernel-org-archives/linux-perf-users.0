Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C62AF1D;
	Wed,  9 Oct 2024 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728453444; cv=none; b=FhwwrSua/yEg2FjiCwKpGjr6nT5u5eESqmg01769Rey5PsoO+i2B5h+URhNS1ygBpm2eU9wkPx7xGRKmhUVaxuWvuKQ+7zmn9SBEMQkUytXjU+PU1N0qxzAGqyYa7WL/Xpg/Z4iCW8VLUVMUHDMKGvQBh2qQduB0Do/f2sTzAyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728453444; c=relaxed/simple;
	bh=O47oLuUo0QpBQXj9j/uC1ds8BU2RT5AQtzut8uxV5mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWFYKb6KmoOzncetOz7w+Qpf7DJeiPkaTZygXMv5OWEAUkuMNVbXFG7RWtIpOWmPwxqXstZr5ImnS/hvb0+bKWFsyK3J/KVgmZOt0UqydpApexfrstPnHS+SWJhUStuLePjs7mZDw6A0YSamrirMwlpTQ9UXGr6bFIpfgSMWt/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzH2OzNB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzH2OzNB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D8AC4CEC5;
	Wed,  9 Oct 2024 05:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728453444;
	bh=O47oLuUo0QpBQXj9j/uC1ds8BU2RT5AQtzut8uxV5mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzH2OzNBukfBQH9Xj6C5hX3Npe9QXUokzYwTBOiqGl3h1ySm/hJrcACU21aMzSEOt
	 y/ReqpKAnKby2JnSuvzBbUMJunFcGkSKllfrBARheTesSvqBlleB0urvgKEaeX4AI9
	 q8R/OjvwQ+/3z3UdXku1q94bY5pro03Nq2KkPmngbaFrfz1WgBJM4vHDxAjVGuOP0m
	 AoPdUa+QRT3W+MP2yN6TtGaUOYIG8TNgO+U2Tqg4Xh4xFI1lCGrobwJrDCyu2BP9cP
	 5POMWcARoq8FA8HJKsA2dvR8vG2MEcTtf8BoJdWjYNgnNLyfCqpJk++V7A/Cz+S5E2
	 RbUfnlRvpKRpA==
Date: Tue, 8 Oct 2024 22:57:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Howard Chu <howardchu95@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
Message-ID: <ZwYbQswnGHSstClc@google.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
 <20240705132059.853205-2-howardchu95@gmail.com>
 <6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org>
 <ZtJWEVn8-w07Wm0q@x1>
 <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org>
 <ZtYJ0z8f-1jwYSbV@x1>
 <c279ad02-2543-4a95-9404-9304e1e704da@kernel.org>
 <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org>

Hello,

On Tue, Oct 08, 2024 at 11:09:31AM +0200, Jiri Slaby wrote:
> On 27. 09. 24, 7:09, Jiri Slaby wrote:
> > On 02. 09. 24, 20:54, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Sep 02, 2024 at 07:25:17AM +0200, Jiri Slaby wrote:
> > > > On 31. 08. 24, 1:30, Arnaldo Carvalho de Melo wrote:
> > > > >   From 174899051e54ecdab06c07652a3d04ad000ab301 Mon Sep 17
> > > > > 00:00:00 2001
> > > > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > Date: Fri, 30 Aug 2024 19:53:47 -0300
> > > > > Subject: [PATCH 1/1] perf tools: Build x86 32-bit syscall table from
> > > > >    arch/x86/entry/syscalls/syscall_32.tbl
> > > > > 
> > > > > To remove one more use of the audit libs and address a problem reported
> > > > > with a recent change where a function isn't available when using the
> > > > > audit libs method, that should really go away, this being one step in
> > > > > that direction.
> > > > > 
> > > > > The script used to generate the 64-bit syscall table was already
> > > > > parametrized to generate for both 64-bit and 32-bit, so just use it and
> > > > > wire the generated table to the syscalltbl.c routines.
> > > > > 
> > > > > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > > > > Suggested-by: Ian Rogers <irogers@google.com>
> > > > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > > Cc: Howard Chu <howardchu95@gmail.com>
> > > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > > Link: https://lore.kernel.org/lkml/6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org
> > > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > 
> > > > Tested-by: Jiri Slaby <jirislaby@kernel.org>
> > > 
> > > Thanks a lot! Added to the cset.
> > 
> > Oh, 32bit arm still affected:
> > /usr/lib/gcc/armv7hl-suse-linux-gnueabi/14/../../../../armv7hl-suse-linux-gnueabi/bin/ld: perf-in.o: in function `trace__init_syscalls_bpf_prog_array_maps':
> > tools/perf/builtin-trace.c:3461:(.text+0x899a0): undefined reference to
> > `syscalltbl__id_at_idx'
> 
> Ping -- any input/fix for this?
 
As a quick fix, we may add a dummy syscall table for other archs like
below.  Can you please test this?

Thanks,
Namhyung

---8<---
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 7c15dec6900d8aaa..b7465a879d8bf416 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -46,6 +46,11 @@ static const char *const *syscalltbl_native = syscalltbl_mips_n64;
 #include <asm/syscalls.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_loongarch;
+#else
+const int syscalltbl_native_max_id = 1;
+static const char *const syscalltbl_native[] = {
+       [0] = "unknown",
+};
 #endif
 
 struct syscall {

