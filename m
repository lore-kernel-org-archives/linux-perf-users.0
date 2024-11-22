Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48F1714C4
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Nov 2024 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732311323; cv=none; b=SSmv53an1MrUQ9khtA/EAWc9zpjUNe4XiOE+6KutSJl2AE30VefNJvL1dNTYtEGvUlRGji1kRXY36Fji0LMwyN3DedVqe04jkn9ykT9b7P7vuK2lKiV1BxdOUh9gWhSovYC/5mA2n89mDyBdBvkr+JLsPr4MvBmoOUnQaDsgHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732311323; c=relaxed/simple;
	bh=WuFeuiq3iFTnv8ZLkw3I9xCXq1G1SgaUpa6KZtZtr80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XntTRYpm3tVbcZbJ7hcb4h1wLoO7dbKZ47Q27AvT2VlIaFr983bh2lISZjKHf2o9xbTcynPQp6Tg/eCBBGzmrrOqSDkJAwkFxY150hVajRm4Wojv3TjEuZ3JFOHlvajbnpU5sBQ9GKKKmUSdOXVH8dG4vlkrI7tW1si4E/c+iXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Fri, 22 Nov 2024 22:35:16 +0100
From: Guilherme Amadio <amadio@gentoo.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, namhyung@kernel.org
Subject: perf test for inet_pton probe fails to match stacktrace
Message-ID: <Z0D5FDu/sErQ0V/2@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Arnaldo, Namhyung,

I've had this test fail for me since a while, so I'm reporting below
in case we can find a good solution to fix it on my system without
breaking other OSs. The test that fails is this:

gentoo ~ # perf test -vF inet_pton
--- start ---
ping 303105 [029] 47754.974977: probe_libc:inet_pton: (7f70ca48feb7)
7f70ca48feb7 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
7f70ca4a2517 gaih_inet+0x112 (/usr/lib64/libc.so.6)
FAIL: expected backtrace entry ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" got "7f70ca4a2517 gaih_inet+0x112 (/usr/lib64/libc.so.6)"
---- end ----
 92: probe libc's inet_pton & backtrace it with ping                 : FAILED!
gentoo ~ # perf version
perf version 6.12

Here's why it fails. My stack traces has more than the test expects:

gentoo ~ # perf script | tac | sed -e /^ping/q | tac
ping  267392 [010] 42482.886216: probe_libc:inet_pton: (7f168d9b4eb7)
            7f168d9b4eb7 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
            7f168d9c7517 gaih_inet+0x112 (/usr/lib64/libc.so.6)
            7f168d9c8b73 getaddrinfo+0x133 (/usr/lib64/libc.so.6)
            55947171a518 [unknown] (/usr/bin/ping)
            7f168d8d6a72 __libc_start_call_main+0x7a (/usr/lib64/libc.so.6)
            7f168d8d6b29 __libc_start_main@@GLIBC_2.34+0x84 (/usr/lib64/libc.so.6)
            55947171ac55 [unknown] (/usr/bin/ping)

Likely this is due to how I compile glibc:
gentoo ~ # cat /var/db/pkg/sys-libs/glibc-2.40-r5/CFLAGS
-Og -march=native -Wl,--build-id -gdwarf-4 -fno-builtin-strlen -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer

If you could suggest a way to fix this, I'd appreciate it.

Best regards,
-Guilherme

