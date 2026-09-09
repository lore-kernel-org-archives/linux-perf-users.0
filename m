Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB53C4B6F
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986535; cv=none; b=IJjgrJ4o1BORYS0yACLUuADhpMZTwGd9PzDsqRA0ONm8N6un/i6UxDk1ttAXVsnKdSNLLjnWvBuV6NjYI5CMab4W5LosBlIP6OALHX+al6QYvfn6uc6JRDzPbx722C1ScRwoabnW9oWUEBg+qqTvKcQnJ7pwIspfAD5LifFxJtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986535; c=relaxed/simple;
	bh=PWmQZNXkDXG1S6LOfi3I3Pbs1fcT+ILyPhVGzAjtbPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ECDSy2S/u2weu6OX2c49iFSeKfER0oj1CqoDeYe2dZa3audnXxZt0GflkjaG5TIxThv0DoT8xO67BBJbiURg3jYHZ+gNYnWsfaCJVS5eLDFr0o7nZZYCfPZctEQbuCt6mtkDNYPaDSnvswzbuDuxlMOq7EgD4RnWofkwz9+rfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKt8EJkR; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKt8EJkR"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso4097349a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Sep 2026 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788986506; x=1789591306; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DyKrFc30n+Tpmvkq5mtTV3A/rE4XcxtweV8BGZqfqvw=;
        b=GKt8EJkRrOMafsXJGjh1zRTnetLFlc2tNpedUmC8OQiUoPInwXnMND7f1carz2zi5D
         vIic17bEcFPixDUqgSv3qwmQzf0bd+zZ7YBaQIMpVpSE2JL4Hl35ThXGZUdwdbOsajiL
         D7UsZz3nmcUut2zpVHjb1syMOU6bAHNEj2ArWhMKJ+KwSRUiO83sLzi0MImt1IXDTUs2
         pbyTHdHpIp85N6PF2vVlzNChsL53N76uccRqAp0AI6zS/9vq6SAqI7egPkJlOrNquXJB
         ZWnjkplY58pvwfvb0C76XwLSu1U7l7qxvOUWbTPQFLFyei2XEv7fgB9VVYyR57sDFEFV
         hobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986506; x=1789591306;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DyKrFc30n+Tpmvkq5mtTV3A/rE4XcxtweV8BGZqfqvw=;
        b=iV4+yx8FZ44VEnAnS5dQ0Xd86FL8ZjHfQk6GlVDENUGyh456Lt1ZNJQANSaf+Wj7K3
         W6v3O1rdUR+n0UvduMmd0fKPEpBHNAqyQ+NsRHRdYoxH2ZIcV0SqB7Bb4EE/BB9Zyxdo
         uDELbjR5t11jUCuQ9HRdd2R2m1u2l/5C9AJGJlMLN8Ah1W6WpmyrvqIU9j0++GU/YlGF
         hdhWh/KPbFYKLkriCgqP2+oV49PGVnUEAKBWaOaqS6DBmOQgbgU29FkJw/6cIwYgoTn7
         Dkw/1Wj2L6Pf17SIS4BAdYYPJ+53TWvP2wYiPrrTO4pv2Z/YiXv/TOWFnP3+X8+b2BLI
         7ouw==
X-Forwarded-Encrypted: i=1; AKwUvBwhFw2DvGS9UDzaZTnWYBMdV8PRzxkJwoNKtyx/NdWCX33VPhREkWAes8xFe7ER34ZuCJjOJwd2OpeYbfghDfcN@vger.kernel.org
X-Gm-Message-State: AFuF++lj+rmsAgPOYjbouskxlXduqZDS13IzyIZIohspAp6cbFKZYGv2
	wq4SRPSxLARLJuO/Rp2Lk49YhjyeKRKiSz6AB+OJq/DDbYDB4Bi+PHKKEP85tbc7UZj5GPWkNWh
	HBZ1SXA/g0Q==
X-Received: from dybkf17.prod.google.com ([2002:a05:7301:3a91:b0:339:770d:7243])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b8d:b0:398:b426:ca4b
 with SMTP id 98e67ed59e1d1-39b2624f10amr54179219a91.22.1788986505882; Wed, 09
 Sep 2026 13:41:45 -0700 (PDT)
Date: Wed,  9 Sep 2026 13:41:22 -0700
In-Reply-To: <20260909204122.1993010-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909204122.1993010-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909204122.1993010-5-irogers@google.com>
Subject: [PATCH v2 4/4] objtool: Add explicitly sequenced -lzstd to libopcodes fallback
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Tomas Glozar <tglozar@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Leo Yan <leo.yan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Distributions like Fedora currently ship a statically compiled binutils
libbfd (an intrinsic dependency of libopcodes) that internally utilizes
zstd to decompress sections.

Because objtool resolves host dependencies sequentially via a manual HOSTCC
shell loop, build failures will occur (e.g. undefined reference to
'ZSTD_decompress') unless the loop probes for it.

Add the '-lopcodes -lbfd -liberty -lz -lzstd' combination to the fallback
chain, assuring successful compilation on hosts packaging static binutils.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/objtool/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index a4484fd22a96..141b957c566b 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -88,7 +88,8 @@ LIBOPCODES_LIBS := $(shell \
 	for libs in "-lopcodes" \
 		    "-lopcodes -lbfd" \
 		    "-lopcodes -lbfd -liberty" \
-		    "-lopcodes -lbfd -liberty -lz"; do \
+		    "-lopcodes -lbfd -liberty -lz" \
+		    "-lopcodes -lbfd -liberty -lz -lzstd"; do \
 		echo 'extern void disassemble_init_for_target(void *);' \
 		     'int main(void) { disassemble_init_for_target(0); return 0; }' | \
 			$(HOSTCC) -xc - -o /dev/null $$libs 2>/dev/null && \
-- 
2.55.0.1003.g10538fe699-goog

