Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D999E555;
	Sat, 24 Aug 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724517208; cv=none; b=ffD6997/SVlV7+yAuiyQeBVn4TDzdM8S02B4nHSC8N0E+0B4R8Dyp+G4PJewIHTdbaAUHQ6ZZpRGzvEgyVnU5ZHBvB1eSPG8N9tFv5vmJrRqwauZDFKUnrK1XaSquZdooHjQm3OmfVGoA0+ztqI2S9tzRxWzFmaL6zMWiivHz5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724517208; c=relaxed/simple;
	bh=0XSPuBJyr7MI7i2ztzRbQfVkoE+7lpYJw/RBOzLBlCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIXoJ2BFsexN/MezUmbipsCFKEPoe/bS963a8T+Akfq48PuVMkpI5Kx69WdH2A3jZPcBe7wnY6yjBNcwso4bbxW8M3wXg+XKlZO1WUohqFHjpZO4SVHQ6mAmfdjfExlT9OQeAMKSUpE6k1w/XxWP085bl9g/S5GoVscbhHT49e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT1tK8rr; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT1tK8rr"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7bcf8077742so2078384a12.0;
        Sat, 24 Aug 2024 09:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724517206; x=1725122006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C85KqAAAhN18wKRLjBvwUf/+LFGPqVcOgeiugyv8dVo=;
        b=cT1tK8rrG4ZeK8eGVkj2QOYgqTqPpAqOl3BGWIP07Sryp+id2JQUwVc1ugnK99bNFe
         ew9CeNQo6iERdQ4ma7wmwx0r+fm3LX/yVegGIzbHn0qVxRYoAy7siN//TUAnO2CphOUZ
         rtQc/Bbnb3QFJzDG8C1ZNfxLelchOmDOhrSGfR77K55VTE/lDe3icJ62riNmqPzrOBNT
         IBAWwbR82YFQ1EVJ+g2VLsf0ZuqW2luuhpGNIZnTWILeLVH2gawUjVXvJs3zDZ0IawVu
         SGDxZV6OrrUvXHik0M4bxhGr01JkLNhf1dqOyWHVlwffw3N49B2HRQ0KEFRC9mrBjTYu
         7KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724517206; x=1725122006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C85KqAAAhN18wKRLjBvwUf/+LFGPqVcOgeiugyv8dVo=;
        b=Ju8Qk7ctOqS4moH6cMVyjdnEyOvxvFrmKTow9eoud9kj++Bj4wpbeVBCX+sPjerMnF
         qDd35FMBJKZ2UA+vIloQbB+W35IUIfMFxZZ3lvJ2EPy/fiqBq32hXQP/bIXIizh10FRs
         v3jWFe5wjX9rBRDinZMs0UBqAbstrGWHh+zn1FyDbdIEHLzTWp/SOpDz2Wv2ZttXlNRG
         qDiuw7gj99MfAuav66DJJH28ID5CK7swodWOY/sqlWuUMvnd5cBNdHDzikkhe6GN1zpJ
         GGh/PcuHO3duSPri7hdnYjosq4fKGUYpUODLcqiU6q3masSy1xp34rg9u23i4QL7ydje
         hxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQzallG5qhyjM0r55qwzhgQSenvy7ansqe4dSv3B+pDmVFYoH+gB9FtjqWo6UdLeFIJYSaff6oGV6gbfo6hU4cJg==@vger.kernel.org, AJvYcCUULgaKT5NKj4kEtbu2Qf0IzJyRIc1usjzyZQh+gfy0dceIYCK4Kn0NAbLHzdIGOjoAClzyDdIN9kHHYIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/x3kyFgdiSpws+zwfhbKyqicNjbPHUTWMzE+uwFnU/0+38Qn
	mVFHf2znjXP4lAeHrtsOxZXRLge6CcgAQohWaY101jXr/lgy6se7
X-Google-Smtp-Source: AGHT+IF9mdrAgIZYcoAltJEvEmFjhJxhqOkAPuFza4sAbQvkO/TxJ0n84w202A2CYS3sAwnTG5qrQA==
X-Received: by 2002:a17:90a:f08a:b0:2d3:ce3d:84d9 with SMTP id 98e67ed59e1d1-2d646bcd396mr6230537a91.7.1724517205542;
        Sat, 24 Aug 2024 09:33:25 -0700 (PDT)
Received: from localhost.localdomain (104-58-203-241.lightspeed.sntcca.sbcglobal.net. [104.58.203.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613941ee7sm6376216a91.24.2024.08.24.09.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 09:33:25 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 1/8] perf trace: Fix perf trace -p <PID>
Date: Sun, 25 Aug 2024 00:33:15 +0800
Message-ID: <20240824163322.60796-2-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240824163322.60796-1-howardchu95@gmail.com>
References: <20240824163322.60796-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'perf trace -p <PID>' work on a syscall that is unaugmented, but doesn't
work on a syscall that's augmented (when it calls perf_event_output() in
BPF).

Let's take open() as an example. open() is augmented in perf trace.

Before:

  $ perf trace -e open -p 3792392
     ? (         ):  ... [continued]: open()) = -1 ENOENT (No such file or directory)
     ? (         ):  ... [continued]: open()) = -1 ENOENT (No such file or directory)

We can see there's no output.

After:

   $ perf trace -e open -p 3792392
      0.000 ( 0.123 ms): a.out/3792392 open(filename: "DINGZHEN", flags: WRONLY) = -1 ENOENT (No such file or directory)
   1000.398 ( 0.116 ms): a.out/3792392 open(filename: "DINGZHEN", flags: WRONLY) = -1 ENOENT (No such file or directory)

Reason:

bpf_perf_event_output() will fail when you specify a pid in 'perf trace' (EOPNOTSUPP).

When using 'perf trace -p 114', before perf_event_open(), we'll have PID
= 114, and CPU = -1.

This is bad for bpf-output event, because the ring buffer won't accept
output from BPF's perf_event_output(), making it fail. I'm still trying
to find out why.

If we open bpf-output for every cpu, instead of setting it to -1, like
this:

  PID = <PID>, CPU = 0
  PID = <PID>, CPU = 1
  PID = <PID>, CPU = 2
  PID = <PID>, CPU = 3

Everything works.

You can test it with this script (open.c):

  #include <unistd.h>
  #include <sys/syscall.h>

  int main()
  {
	int i1 = 1, i2 = 2, i3 = 3, i4 = 4;
	char s1[] = "DINGZHEN", s2[] = "XUEBAO";

	while (1) {
		syscall(SYS_open, s1, i1, i2);
		sleep(1);
	}

	return 0;
  }

save, compile:

  make open

perf trace:

  perf trace -e open <path-to-the-executable>

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240815013626.935097-2-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ef58a7764318..f14b7e6ff1dc 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1067,7 +1067,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!threads)
 		return -1;
 
-	if (target__uses_dummy_map(target))
+	if (target__uses_dummy_map(target) && !evlist__has_bpf_output(evlist))
 		cpus = perf_cpu_map__new_any_cpu();
 	else
 		cpus = perf_cpu_map__new(target->cpu_list);
-- 
2.45.2

