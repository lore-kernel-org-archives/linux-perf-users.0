Received: from hudzen10.theunixzoo.co.uk (hudzen10.theunixzoo.co.uk [176.126.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC62BF3EA
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.126.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924268; cv=none; b=SmREY54JOmrW3bnGM+nP0UIrpbYU2toBfht4eHqontISS7yJWYB/VHLFHpUXHm6f7/E93TFR97omNoBuJrMSmLbbaErarNEopu2Ox8rJWXl+wCMAOhlF/xJQfdF8GqAiPHyy8qRuZifu8NreupiIm8MHenv49qMwq4Sih9lumwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924268; c=relaxed/simple;
	bh=/k3Ns3L3lMpkxfys7wFKiGsbMrsgfN9ffHHpTrihm3U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OgJHmKOVB6UaiUkXkCK8VatpwXULKsOakR1QsT1xMsGf9FhAc9eNnioWjuyBPSTShnKn+t+sQr/dcobKPQJaL9x4q2DEryORXKAq667o80CKl/XObeVoYGjMhLkjkCDdCtD9Ll327/CMKT7grW210Wbc1AdQGkKaf6K19xYPc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theunixzoo.co.uk; spf=pass smtp.mailfrom=theunixzoo.co.uk; dkim=pass (2048-bit key) header.d=theunixzoo.co.uk header.i=@theunixzoo.co.uk header.b=T+tmfW5i; arc=none smtp.client-ip=176.126.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theunixzoo.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theunixzoo.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theunixzoo.co.uk header.i=@theunixzoo.co.uk header.b="T+tmfW5i"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=hudzen10; bh=/k3Ns3L3lMp
	kxfys7wFKiGsbMrsgfN9ffHHpTrihm3U=; h=subject:to:from:date;
	d=theunixzoo.co.uk; b=T+tmfW5iu1rOZy07PGaKd/3KCrAjsaR8q4xx4xsb+JkPYf2e
	B9OrHyORjwlCAVAK432sRXcZwfxQONfYoMUQJ5kPuWWa4ZFcTpKyaRhTsAgtGl/xblSApq
	DGnxs77qYBD/opsftyysLn2rWJ/OeoQNvqVfngYpih5TELPkyU7KiOy82su/jqunTpynts
	VSCDJNHlPfhfqDxVv1Dar6YOgJ3cEtR+LOuyCKa46Cs7Fhk5bXct+jZovhG40jR20wH5rO
	zIHVxUEdRQqO7GRrkKlbloaOZdGedi8o8ayO0onzKIbnYdAGnY7MgL2cSNcK+8RK7RrcUd
	DtD10cm8y1+tJQ==
Received: from localhost (<unknown> [94.119.32.21])
	by hudzen10.theunixzoo.co.uk (OpenSMTPD) with ESMTPSA id 4ca3bce3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) auth=yes user=edd
	for <linux-perf-users@vger.kernel.org>;
	Tue, 29 Apr 2025 11:57:44 +0100 (BST)
Date: Tue, 29 Apr 2025 11:57:38 +0100
From: Edd Barrett <edd@theunixzoo.co.uk>
To: linux-perf-users@vger.kernel.org
Subject: perf filters don't work correctly inside containers
Message-ID: <aBCwoq7w8ohBRQCh@fremen.lan>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm writing a userspace application that interacts directly with
perf_event_open() in order to trace control flow with Intel PT.

Recently I optimised this application by using an ftrace filter to trace only
the segment of code of interest, but to my surprise I couldn't get my work
merged because the tests failed inside the dockerised CI pipeline we use. Upon
closer inspection, the traces look empty (apart from some boring non-control
flow PT packets).

I was then able to reproduce the problem using the standard userspace perf
tools. I *think* (but I'm not sure) that this might be highlighting a bug in
perf when used in containers.

I'm using Debian stable:
```
# cat /etc/debian_version
12.9
# uname -a
Linux bencher16 6.1.0-31-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.128-1 (2025-02-07) x86_64 GNU/Linux
```

Here's a minimal example that shows the issue. Suppose we want to trace the
executable segment of /bin/ls with Intel PT. First, let's do this *outside* of
docker to see what we expect to get:

```
host$ readelf --segments /bin/ls
...
Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
...
  LOAD           0x0000000000004000 0x0000000000004000 0x0000000000004000
                 0x0000000000015759 0x0000000000015759  R E    0x1000
```

There's our executable segment. To collect a trace of it, we can do:

```
host$ perf record -e intel_pt//u -v --filter 'filter 0x0000000000004000/0x0000000000015759@/bin/ls' /bin/ls -- /dev/null
DEBUGINFOD_URLS=
Address filter: filter 0x4000/0x15759@/usr/bin/ls
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
mmap size 528384B
Control descriptor is not initialized
mmap size 528384B
perf_event__synthesize_bpf_events: can't get next program: Operation not permitted
/dev/null
[ perf record: Woken up 1 times to write data ]
failed to write feature HYBRID_TOPOLOGY
[ perf record: Captured and wrote 0.035 MB perf.data ]
```

Then we can look at the PT packets and verify we see some TNT and TIP packets,
as one would expect:

```
host$ perf report -D
...
.  00002d98:  06                                              TNT T (1)
.  00002d99:  59 e6 00 00 00 00                               MTC 0xe6
.  00002d9f:  c1 b0 d0 66 5f 80 7f 00 00                      TIP.PGD 0x7f805f66d0b0
.  00002da8:  00 00 00 00 00 00 00                            PAD
.  00002daf:  d1 34 4b 7c 4b 82 55 00 00                      TIP.PGE 0x55824b7c4b34
.  00002db8:  04 00 00 00 00 00 00                            TNT N (1)
.  00002dbf:  c1 b0 d0 66 5f 80 7f 00 00                      TIP.PGD 0x7f805f66d0b0
...
^C
host$ perf report -D | grep -e 'TNT' | wc -l
130
host$ perf report -D | grep -e 'TIP' | wc -l
190
```

Good. Now let's repeat this experiment inside a docker container (one that has
the PERFMON capability enabled).

As is happens, the executable segment for the container's `ls` is at the same
offset as in the host:
```
container$ readelf --segments /bin/ls
...
Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
...
  LOAD           0x0000000000004000 0x0000000000004000 0x0000000000004000
                 0x0000000000015759 0x0000000000015759  R E    0x1000
```

In light of that the `perf record` command is the same:
```
container$ perf record -e intel_pt//u -v --filter 'filter 0x0000000000004000/0x0000000000015759@/bin/ls' /bin/ls -- /dev/null
DEBUGINFOD_URLS=
Address filter: filter 0x4000/0x15759@/usr/bin/ls
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
maps__set_modules_path_dir: cannot open /lib/modules/6.1.0-31-amd64 dir
Problems setting modules path maps, continuing anyway...
mmap size 528384B
Control descriptor is not initialized
mmap size 528384B
perf_event__synthesize_bpf_events: can't get next program: Operation not permitted
/dev/null
[ perf record: Woken up 1 times to write data ]
failed to write feature HYBRID_TOPOLOGY
[ perf record: Captured and wrote 0.056 MB perf.data ]
```

But this time there are no TIP or TNT packets to be seen:
```
container$ perf report -D | grep -e 'TNT' | wc -l
0
container$ perf report -D | grep -e 'TIP' | wc -l
0
```

I find this behaviour unexpected. It suggests that the executable segment
wasn't traced. I'd expect a container to be able to trace with a filter the
same as if it weren't a container at all, but maybe my expectations are
wrong(?).

One theory is that perf filtered on the host's /bin/ls, which of course wasn't
executed, however despite trying, I've been unable to confirm this.

I tried, for example, specifying the host's path to `ls`
(/var/lib/docker/overlay2/...) in the filter string, but perf will reject this,
presumably because it checks the path exists in the guest filesystem. Copying
`ls` to that path in the guest doesn't give us a trace with TIP and TNT
packets, so I'm not sure what's going on.

Does anyone know if filters should work in containers?

Thanks

-- 
Best Regards
Edd Barrett

https://www.theunixzoo.co.uk
