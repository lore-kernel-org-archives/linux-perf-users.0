Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A401BEF9B;
	Fri,  3 Jan 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892927; cv=none; b=s2VLWIQh7D0CZbWznzVF3U+KWmHjh+ECFrSv9rBlKc71Sp7uI9ms5QpJyBB/IUyrfNqYD92fDM9gZTc73DUZ6ZnUIyqaZDGQh6AkLuD58m6W+qaJ2g6aT8yn0apKmKoTNdSXMD6ZGBhKNxewQPLogCnhL8nJx7FGkC1pxTJYyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892927; c=relaxed/simple;
	bh=MNg0bR07r9eZz65eb9hxnSfxd6HNsAS09M96vJSAEvI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hi4cVPbpkTCTJWRmSs+0r2P64YEzRxyOIGwMw53mP/ZlhQzqMV4uM8paqJEXUtVmD2TTvUMQ+fZY0I2avUYdLXNu7EbsKFirGtqiSlLTL993oQ9lCIdmdhFOBKwX3aXBMKd2IgsRnqJEjk9GMc6wlklXMrHH7wHXn5eDcm3I9m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LflL+617; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LflL+617"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso1261794266b.1;
        Fri, 03 Jan 2025 00:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735892924; x=1736497724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MNg0bR07r9eZz65eb9hxnSfxd6HNsAS09M96vJSAEvI=;
        b=LflL+617MZKMGjDspoCh5C93WuUPgOtaikSq7fp7u3jcxXcBhR4I8c+0FrvWpc0Fbr
         HowYPjFHnvRmbyGvq9ejkpwQx/5LYXIUqbV7YADEslVDy9KBnJ5u/h8JhmOHcnjt4shj
         hHLodaz4VJ/+hix6BfpMTwGUk1G0FyHX0fiVszPuF7K0SES3GizZvcjZZx6dFfwYeB/+
         weXAinQA7ktsjXO87iBgI2pihyhsQCN/2DbNQqEMyZei/PaI820gZUQfcqzQixHzryYF
         x+XYvqxNlx8QRBAcTyOnaGHvINuXZZPy5Jie6kkaytrZsM5htAudBlfG/lLkQWlbRSFh
         kkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735892924; x=1736497724;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MNg0bR07r9eZz65eb9hxnSfxd6HNsAS09M96vJSAEvI=;
        b=jqriB9/7yaGLBGkJCdH6rYYdDwUataEICn4Ky2GtUa6HNgZZdj1v+DE4qlcIe1smHO
         LohvQcL/Ws14YoJJJh1u+FkvTN6Pv8qF1m5+JssBsEBsUb/HiqzfMBNbZx8S+BEjc9k6
         55hgAlPPncrTYNNpRv9NUiuNmVHc+QCPQGLXJqYvQ1WemO12VecUneCWDZECLLIWb4oJ
         yMIdHVeov2YNA3DIa20F/en/qmj6XCWWJUdT1qJ2KfteVfyktLRJ4nUA6w3C4ALXB5ln
         5drqo6ZVK/+UTTxOMkNfhIcJUZCsuLqxGuk9BRPGJrxaTp0O8NXdr7rX8GLA03e1Pddh
         KUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4a4cfdyeRaeOFI3EHDUS2b3ug0sFL29CalORW64A+uFxZ4B43VDjRJU1slXfHfDDkh2mAiv7vx9CtL6YvJ1db7A==@vger.kernel.org, AJvYcCW/WgD6bqmERsgGSu6bss3u/IHqh9N3SJ2C4cuT5Nn0hBtaxlK/nVM4ROgGXK+swVTxUixYSs3x19TqpmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZoFcjtA8jCa/9ldfwVppp9L0uafjGrKLQSpepphvRu/rAmQT4
	8dPizSVzkp9nQv/Iwc7mlLpvusg+wDCSfO5+o1kOGj7rPveTg+g7Q9bSTCz+vLn/jq138J8JhE8
	YQzfczmlB7neEJbjtq1Pe0D6r+eY=
X-Gm-Gg: ASbGncvCiX8oy3Zc0lNqKDPy/REJ/UfbiN2jbMACG1xjYLd+x/VQZn81JHnyf57jdob
	i6gIWnMfpiJ5bmJjzSUkozvMv/5Gr25VhCCDU51k=
X-Google-Smtp-Source: AGHT+IGBUVpi+n9HSYWQ3ZbMc8biBwxipZKCOJb+h+Wymxve6aL9rZJ0JoRKBxtTeMhMHZR74/tkpHYlngeMDwh6qGk=
X-Received: by 2002:a17:906:730f:b0:aa6:80ed:e9a3 with SMTP id
 a640c23a62f3a-aac2d47a722mr4781321666b.35.1735892922289; Fri, 03 Jan 2025
 00:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Fri, 3 Jan 2025 16:28:30 +0800
Message-ID: <CAKHoSAvi5LZENKr4dKqwbpQ3dXrDS_3=O-d43BpptZTVipehrQ@mail.gmail.com>
Subject: "INFO: rcu detected stall in corrupted" in Linux kernel version 6.13.0-rc2
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 6.13.0-rc2. This issue was discovered using our
custom vulnerability discovery tool.

HEAD commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4 (tag: v6.13-rc2)

Affected File: arch/x86/events/core.c

File: arch/x86/events/core.c

Function: x86_pmu_enable_event

Detailed Call Stack:

------------[ cut here begin]------------

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
3-...D } 10 jiffies s: 121 root: 0x8/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 0 to CPUs 3:
loop4: detected capacity change from 0 to 1024
EXT4-fs: Ignoring removed oldalloc option
NMI backtrace for cpu 3
CPU: 3 UID: 0 PID: 4204 Comm: syz-executor.6 Not tainted
6.13.0-rc2-00159-gf932fb9b4074 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:arch_static_branch arch/x86/include/asm/jump_label.h:36 [inline]
RIP: 0010:native_write_msr arch/x86/include/asm/msr.h:149 [inline]
RIP: 0010:wrmsrl arch/x86/include/asm/msr.h:264 [inline]
RIP: 0010:__x86_pmu_enable_event arch/x86/events/perf_event.h:1219 [inline]
RIP: 0010:x86_pmu_enable_event+0x126/0x2a0 arch/x86/events/core.c:1430
Code: 81 cd 00 00 40 00 48 c1 ea 03 4c 21 e5 80 3c 02 00 0f 85 64 01
00 00 8b 9b 78 01 00 00 48 89 ea 89 e8 48 c1 ea 20 89 d9 0f 30 <66> 90
5b 5d 41 5c 41 5d 41 5e 41 5f e9 a9 c2 45 00 e8 a4 c2 45 00
RSP: 0018:ffff8881058079d8 EFLAGS: 00000056
RAX: 0000000000530076 RBX: 00000000c0010200 RCX: 00000000c0010200
RDX: 0000000000000000 RSI: ffffc90008bc0000 RDI: ffff888106bb2d10
RBP: 0000000000530076 R08: 0000000000000000 R09: ffffed1022ab4484
R10: ffff8881155a2427 R11: 0000000000032001 R12: fffffdffffffffff
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
FS: 00007f44665b6640(0000) GS:ffff888115580000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2dd24000 CR3: 0000000107544000 CR4: 0000000000350ef0
Call Trace:
<NMI>
</NMI>
WARNING: stack recursion on stack type 6
perf: interrupt took too long (3192 > 3161), lowering
kernel.perf_event_max_sample_rate to 62000
lo: entered promiscuous mode
lo: entered allmulticast mode
netlink: 'syz-executor.2': attribute type 12 has an invalid length.
EXT4-fs (loop4): mounted filesystem
00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode:
none.
perf: interrupt took too long (4025 > 3990), lowering
kernel.perf_event_max_sample_rate to 49000
netlink: 3 bytes leftover after parsing attributes in process `syz-executor.6'.
perf: interrupt took too long (5057 > 5031), lowering
kernel.perf_event_max_sample_rate to 39000
perf: interrupt took too long (6333 > 6321), lowering
kernel.perf_event_max_sample_rate to 31000
ICMPv6: process `sh' is using deprecated sysctl (syscall)
net.ipv6.neigh.lo.base_reachable_time - use
net.ipv6.neigh.lo.base_reachable_time_ms instead
EXT4-fs (loop4): unmounting filesystem 00000000-0000-0000-0000-000000000000.
sg_write: data in/out 2031580/78 bytes for SCSI command 0x0-- guessing data in;
program syz-executor.3 not setting count and/or reply_len properly
loop1: detected capacity change from 0 to 8192
loop1: p1 p2 p3
netlink: 'syz-executor.1': attribute type 1 has an invalid length.
loop1: p1 p2 p3
cgroup: Need name or subsystem set
loop0: detected capacity change from 0 to 1164
loop7: detected capacity change from 0 to 262144
loop1: detected capacity change from 0 to 1024
EXT4-fs (loop1): Invalid log block size: 48537


------------[ cut here end]------------

Root Cause:

The crash is primarily triggered by a malfunction within the Linux
kernel's Performance Monitoring Unit (PMU) subsystem, specifically in
the x86_pmu_enable_event function located in arch/x86/events/core.c. A
bug in this function leads to improper handling of performance events,
which in turn causes significant RCU (Read-Copy Update) stalls across
multiple CPUs. These stalls are exacerbated by excessive interrupt
handling delays, as evidenced by multiple perf: interrupt took too
long warnings. Additionally, the system experiences stack recursion
issues, further destabilizing kernel operations. The combination of
these factors results in severe synchronization and resource
management failures, culminating in a kernel panic and system crash.
Other contributing factors observed in the logs, such as EXT4
filesystem anomalies and netlink attribute parsing errors, indicate
that the PMU issue may be part of a broader set of kernel instability
problems.

Thank you for your time and attention.

Best regards

Wall
