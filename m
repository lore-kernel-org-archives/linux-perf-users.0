Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5F35203F
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037401; cv=none; b=rlId/sXn4rsaBWSTaixBoKaKNexIkb1rgsedin0veuO+R1Tj54BbsA/n9Hwd4UR8ibzOhmWszqa2nh3QmoU78cvMFraj6AdBnbm/Rxrp02N3tiaITK3URpFtlyPo9VHFAj7vBbZNmOd5bbi/h2NpcN0b0mG2RI8PXP+znA/v/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037401; c=relaxed/simple;
	bh=1zFTBXo/D2Dn7zaioloCJ3PMB7X/dTKopEatkpdaaOY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHzzIWsOe2UlEo9lGURCGFmCSWFT1ADtGmp+4lJvBA+BvFBc7mT7XXV4dTiBynPQwBCjBYxb+oaUyvqRPa5Mub16D1egKojlS1T5Ij2EONHCyafNhvvyWPhhBdIMf5Ut+FVj00n5h0nveL4FclNxiMl6kvXCUYXTRniBv5GWPEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He2NJyoE; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He2NJyoE"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-367cbac9c37so8099740a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 23:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780037399; x=1780642199; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:cc:to:from
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=igljlLtxtfZIkBVJqC2QS3pcMFW6ywq/xhptp5glkXk=;
        b=He2NJyoEQbL3wL4Y0O68gTagaXxLvvzfy0uIrB++8BBGpzomjXXW1mpL6l6q7X2UHC
         EmBFhJ4V1PfoeG5oZT1+qROR/Xzj5H6zWQOBfZ0goi/agR+885QoQ4TXnvLbzIPywRJI
         23jE0rQNLoubb/M1vOZ858Yjpari8SFTf+ufZ9F7Etp5/WRQXe8RvIGcKi3K/reOGHca
         hgen3NeZj/9mt8DfkjX/6mXm8S1oX1EDlSNWQXOC6VwEkrwxWaRlGMPgHYopjjpwvu9z
         0ZMP9r2W/QJd3u7XjkvBtwrBq4AueKgoCtjKMlkYC2/ah5Go5bbshg0T6VDIfg4VZeLS
         LOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780037399; x=1780642199;
        h=mime-version:references:in-reply-to:message-id:date:cc:to:from
         :subject:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igljlLtxtfZIkBVJqC2QS3pcMFW6ywq/xhptp5glkXk=;
        b=qLlKm8YuZ2TOAyjWKrIiU8X5ifIjk6zPLLkzT3xpTFboGMSbl+UjRWaKsuCVrDfTqG
         HwbbhMzFn+ELkAkLyFjxx5u8lj0+ZyMcrh795aDRwB82Nq4/5WxhG7JiPAGiMZFhnqAc
         5yGjNW/Ob22KDTyTnkp647S24447efjfoQ/A/KAsT9TRS2SEo7wfV+J2J5N1xR7im/5H
         fSfU7h4okWENBYdI3tXrdUHjDrzSuXEYr6G6myj4h3IsVsvvfwc06PhuLvo3USFOSVhb
         r1x4MfvArWiMKCoSL7XijAXXH4fad+iGjw6n0TB88ULGGSA/4HvfuYmuQdIa00q6m3Fw
         6rag==
X-Forwarded-Encrypted: i=1; AFNElJ9d6vN5xkAlJrudlMuhni9AFxz5Pzy8I7gPju/qvnmcSxY6reijceSWz2J2SVPEwGWoGDbKQNy+EuAoS/bz/BTQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6/Fmzw1bCy0h3DYF6SgVZiJMV4glpJSfV53ba/kaAihplXKP
	aKT24T2k5YOnQW0FXYy+xP75Jbf7m6CemnV1hkLBIJ5PTTp92C8eS9N0
X-Gm-Gg: Acq92OEPU+gAr8tF7R/1D9eAzOoxgByBhI6o+GRtSeDg9zyqh3mOn83JXfxB1nxi3hn
	ZXij2r2d6k60xGG8uHmUGDAi6KnKkTN9gVCzfsD4FN/+2MHAFlm3L8HYIDqTeKw95nXBQYjhDRx
	UtJMs92unt9mA0phOMc108A7mcjhz2kfR1QCZtMZJFC6UHM2fpRzT0qkja0Rsx6KOcwEEtWnNzP
	m+wDR+9pymnfG4rT3KIgyszmbsdc0vjgmZ3V3UhCZ2Jz+yNlhz14LJ8za7B2ZuqW+ZARVedUICA
	2fYM4Qod5Rgl4weFcyGFSGsq0QPwqZZy+Ug74TWVXCyQH+Evpzh0Cz4lgjGdmdF2Kux/DWps3FM
	sTb40im/2nSt5Lnm9cTSZF+IO9IeTiTLHJSYtWIemCsY7uFKZpWxiVedAetKZbUa/9F3QNb5yKK
	34PrWI1QKUmvxbXdM1YG9vvbr6QwVPf+mxZ1wXlYha4LG7NlgW
X-Received: by 2002:a17:90b:4ccf:b0:36b:71e6:3df1 with SMTP id 98e67ed59e1d1-36bbcad572cmr1880425a91.3.1780037398935;
        Thu, 28 May 2026 23:49:58 -0700 (PDT)
Received: from [127.0.1.1] ([104.28.157.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0c1ab21sm952626a91.14.2026.05.28.23.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 23:49:58 -0700 (PDT)
Subject: [PATCH 1/6] perf/sched: fix memory leaks in schedstat processing
From: Wang Haoran <haoranwangsec@gmail.com>
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 haoranwangsec@gmail.com
Date: Fri, 29 May 2026 14:49:51 +0800
Message-ID: <178003739172.62097.18263671852132331815@gmail.com>
In-Reply-To: <178003738371.62097.10360938456907564684@gmail.com>
References: <178003738371.62097.10360938456907564684@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4800197882669851314=="

--===============4800197882669851314==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 82a2414eac53e2052646a1c90a8eb8c03cecef22 Mon Sep 17 00:00:00 2001
From: Wang Haoran <haoranwangsec@gmail.com>
Date: Thu, 28 May 2026 15:16:39 +0800
Subject: [PATCH 1/6] perf/sched: fix memory leaks in schedstat processing

perf_sched__process_schedstat() allocates a schedstat_cpu (or
schedstat_domain) struct and its embedded data pointer, but fails to
free either when the data pointer allocation fails or when the
after_workload_flag path discards the temporary struct after diffing.

free_schedstat() walks the cpu_head list and frees each node but
omits the cpu_data and domain_data pointers allocated inside each
node, leaking them on every normal exit path.

Fix all three cases:
- free temp on zalloc failure of the inner data pointer
- free temp and its data pointer after store_schedstat_*_diff()
- free cpu_data/domain_data inside free_schedstat()

Fixes: <schedstat processing code>
Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
---
 tools/perf/builtin-sched.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 3f509cfdd..ab4c9ffa4 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4413,8 +4413,10 @@ static int perf_sched__process_schedstat(const struct =
perf_tool *tool __maybe_un
 			return -ENOMEM;
=20
 		temp->cpu_data =3D zalloc(sizeof(*temp->cpu_data));
-		if (!temp->cpu_data)
+		if (!temp->cpu_data) {
+			free(temp);
 			return -ENOMEM;
+		}
=20
 		memcpy(temp->cpu_data, &event->schedstat_cpu, sizeof(*temp->cpu_data));
=20
@@ -4439,6 +4441,8 @@ static int perf_sched__process_schedstat(const struct p=
erf_tool *tool __maybe_un
 			domain_second_pass =3D list_first_entry(&cpu_second_pass->domain_head,
 							      struct schedstat_domain, domain_list);
 			store_schedstat_cpu_diff(temp);
+			free(temp->cpu_data);
+			free(temp);
 		}
 	} else if (event->header.type =3D=3D PERF_RECORD_SCHEDSTAT_DOMAIN) {
 		struct schedstat_cpu *cpu_tail;
@@ -4448,8 +4452,10 @@ static int perf_sched__process_schedstat(const struct =
perf_tool *tool __maybe_un
 			return -ENOMEM;
=20
 		temp->domain_data =3D zalloc(sizeof(*temp->domain_data));
-		if (!temp->domain_data)
+		if (!temp->domain_data) {
+			free(temp);
 			return -ENOMEM;
+		}
=20
 		memcpy(temp->domain_data, &event->schedstat_domain, sizeof(*temp->domain_d=
ata));
=20
@@ -4458,6 +4464,8 @@ static int perf_sched__process_schedstat(const struct p=
erf_tool *tool __maybe_un
 			list_add_tail(&temp->domain_list, &cpu_tail->domain_head);
 		} else {
 			store_schedstat_domain_diff(temp);
+			free(temp->domain_data);
+			free(temp);
 			domain_second_pass =3D list_next_entry(domain_second_pass, domain_list);
 		}
 	}
@@ -4473,9 +4481,11 @@ static void free_schedstat(struct list_head *head)
 	list_for_each_entry_safe(cptr, n2, head, cpu_list) {
 		list_for_each_entry_safe(dptr, n1, &cptr->domain_head, domain_list) {
 			list_del_init(&dptr->domain_list);
+			free(dptr->domain_data);
 			free(dptr);
 		}
 		list_del_init(&cptr->cpu_list);
+		free(cptr->cpu_data);
 		free(cptr);
 	}
 }
--=20
2.53.0



---
ASan output on perf 7.0.6 (unpatched) with the attached PoC:

0xb0 [0]: failed to process type: 1685713920 [Invalid argument]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D55915=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 73 byte(s) in 1 object(s) allocated from:
    #0 0x7f86f552b60f in malloc ../../../../src/libsanitizer/asan/asan_malloc=
_linux.cpp:67
    #1 0x7f86f4096e6e in __vasprintf_internal libio/vasprintf.c:116
    #2 0x7f86f4143172 in ___asprintf_chk debug/asprintf_chk.c:34
    #3 0x6072f7e48ee3 in asprintf /usr/include/x86_64-linux-gnu/bits/stdio2.h=
:206
    #4 0x6072f7e48ee3 in astrcat=20
    #5 0x6072f7e48ee3 in parse_options_subcommand=20
    #6 0x6072f7de3ef0 in cmd_sched (perf+0x33eef0) (BuildId: 25d667fa7a727404=
6cb5bcb3375c4b1074f3f6db)
    #7 0x6072f7e2887f in handle_internal_command (perf+0x38387f) (BuildId: 25=
d667fa7a7274046cb5bcb3375c4b1074f3f6db)
    #8 0x6072f7c9b836 in main (perf+0x1f6836) (BuildId: 25d667fa7a7274046cb5b=
cb3375c4b1074f3f6db)
    #9 0x7f86f402a600 in __libc_start_call_main ../sysdeps/nptl/libc_start_ca=
ll_main.h:59
    #10 0x7f86f402a717 in __libc_start_main_impl ../csu/libc-start.c:360
    #11 0x6072f7ca3754 in _start (perf+0x1fe754) (BuildId: 25d667fa7a7274046c=
b5bcb3375c4b1074f3f6db)

Objects leaked above:
0x7bf6f33e0800 (73 bytes)

Direct leak of 72 byte(s) in 1 object(s) allocated from:
    #0 0x7f86f552b40f in calloc ../../../../src/libsanitizer/asan/asan_malloc=
_linux.cpp:74
    #1 0x6072f7dcfe52 in perf_sched__process_schedstat (perf+0x32ae52) (Build=
Id: 25d667fa7a7274046cb5bcb3375c4b1074f3f6db)
    #2 0x6072f80fcdc2 in perf_session__process_user_event (perf+0x657dc2) (Bu=
ildId: 25d667fa7a7274046cb5bcb3375c4b1074f3f6db)
    #3 0x6072f8101af8 in process_simple (perf+0x65caf8) (BuildId: 25d667fa7a7=
274046cb5bcb3375c4b1074f3f6db)
    #4 0x6072f8103865 in reader__read_event (perf+0x65e865) (BuildId: 25d667f=
a7a7274046cb5bcb3375c4b1074f3f6db)
    #5 0x6072f810421d in perf_session__process_events (perf+0x65f21d) (BuildI=
d: 25d667fa7a7274046cb5bcb3375c4b1074f3f6db)
    #6 0x6072f7de9f97 in cmd_sched (perf+0x344f97) (BuildId: 25d667fa7a727404=
6cb5bcb3375c4b1074f3f6db)
    #7 0x6072f7e2887f in handle_internal_command (perf+0x38387f) (BuildId: 25=
d667fa7a7274046cb5bcb3375c4b1074f3f6db)
    #8 0x6072f7c9b836 in main (perf+0x1f6836) (BuildId: 25d667fa7a7274046cb5b=
cb3375c4b1074f3f6db)
    #9 0x7f86f402a600 in __libc_start_call_main ../sysdeps/nptl/libc_start_ca=
ll_main.h:59
    #10 0x7f86f402a717 in __libc_start_main_impl ../csu/libc-start.c:360
    #11 0x6072f7ca3754 in _start (perf+0x1fe754) (BuildId: 25d667fa7a7274046c=
b5bcb3375c4b1074f3f6db)

Objects leaked above:
0x7bf6f33e24e0 (72 bytes)

SUMMARY: AddressSanitizer: 145 byte(s) leaked in 2 allocation(s).

--===============4800197882669851314==
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="crash_err234_iter50.data"
MIME-Version: 1.0

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
LDgwLDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMhhNAAAAAAA
AQAAAEAAAAAvaG9tZS9waHJpc20vRGVza3RvcC9saW51eC90b29scy9wZXJmL3BlcmYAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAgAAAEAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAADEAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAQAAAADAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABA
AAAAMQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAAACAAAAQAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAMQAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC
AAAAAQAAAAAAAADIYTQAAAAAAMxGEQAAAAAAQAAAADAtMQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAACAAAAAEAAABAAAAAQAAA
AAgAAABAAAAARGF0YQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAEAAAAAzMksAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAQAAAAEAAAAAIAAAAQAAA
AEluc3RydWN0aW9uAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAABAAAAAMzJLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAEAAAABAAAAACAAAAEAAAABEYXRhAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
QAAAADMySwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAABAAAAAMQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAABAAAAAQAAAAAgAAABAAAAASW5zdHJ1Y3Rpb24AAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAzMksA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAQAAAADEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAACAAAAQAAAAAAEAAAIAAAAQAAAAFVuaWZpZWQAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAANTEySwAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAw
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAgAAAEAAAAAABAAACAAAAEAAAABVbmlmaWVkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAADUxMksAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAMQAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMA
AABAAAAAAEAAABAAAABAAAAAVW5pZmllZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAxNjM4NEsAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAADAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAQAAAAABA
AAAQAAAAQAAAAFVuaWZpZWQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAABAAAAAMTYzODRLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAxAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAIAAAAAAEA
AAAAAAAAAAAAAAAAAAAoAAAAAAAAACgAAAAAAAAA////AP8AAAARAAAAAQAAAAAAAAABAAAAAAAA
AEAAAABQS0cAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAQAAAADAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAzAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAMC0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAAAAAEAAAABQS0cAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
QAAAADAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAzAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAABAAAAAMC0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==

--===============4800197882669851314==--
