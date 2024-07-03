Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC1F17BB3B
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jul 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019031; cv=none; b=h389X2MWuGIFabCnGFEN3INVMvhU2CXx0PRU63REdbletNb8vhfwQX80usckucup1wnMo9bjoW13ubrW6YtRhMCy6GPR1yiOlbuMZsR4AJAM5NBi9//gx0iigYfPhekkR41Ix7N4n5lHGJptO+fHKdLXyGRP68zI9myWmXY6cxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019031; c=relaxed/simple;
	bh=CfjFM4P4hQ/JO2+QcUS22SmSS21QmvUYJaU0ZtSGk2k=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=aGi0E5JSEysrqnJIhG57bmex1WhVUVLq150+Ti1pdVqR4gRm/DwSTcRfVzG80RowPDsuL50hV/XGXL2DN2avOFogaLuaP89iQzjmV/Bg/StcXB4h/GphQu2uetz857T6S1uGwKQL5y9f7QbdvJ65sPHAcPNHx1jokJ5YXXof+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jarm.ar; spf=pass smtp.mailfrom=jarm.ar; dkim=pass (2048-bit key) header.d=jarm.ar header.i=@jarm.ar header.b=bObNLcso; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D8WVrjKM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jarm.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jarm.ar
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jarm.ar header.i=@jarm.ar header.b="bObNLcso";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D8WVrjKM"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0B73A114023A;
	Wed,  3 Jul 2024 11:03:49 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Wed, 03 Jul 2024 11:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarm.ar; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1720019029; x=1720105429; bh=oTyKMMrKZz/h0vAU9aU6GpMvliXDoXYE
	jsog1+FSxag=; b=bObNLcsoasiYwfddlNhefOySJkRilfGJ2y90nafN7j81jQmd
	rvvoNkheokLn7v82835hna8MuWu7juFcxX2guboGW/oODWz/xR4VrVYhI3A32j2B
	ZIf0EwO3h2qglocIT5g7y0V0Qvx/i96CQLBPOZJEIi4rh/COAjdDLn8KBCmNxqVe
	2ZoP0nZWS38QrRBd5qiGlQsn6QrA0qoponB0RnZkplffa4MjDl1kqs8wF0rb1mOx
	iVJbDHs+FKeNfU4GuzWvaqO7drMVreE6qWkLOvuTI1VHbRABSUpc2wxCWRZkC29F
	f8kLhtqQS26DV6q9WOR323eeQbNbof5HkKecBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1720019029; x=1720105429; bh=oTyKMMrKZz/h0vAU9aU6GpMvliXDoXYEjso
	g1+FSxag=; b=D8WVrjKMqwzKvH1uXFoqoxod+KaXqce7GqZlkCilfEI6XogoGLS
	Xj1caifKOVgL0+LpVyoCOoD4h0LOEVg/AJEASnYgQmKm5yJ7uXH1U3xCrscGfJOK
	9fr7yNtQIdQzHOvrdidJnABpeMf2/AfhDsfJW4wc7w9nE8Ta0m3dPT7nbI7m7kTJ
	GiN3aSYDeAB/XJSi1e8ELMuWtJqbU5kis8S2Is/XnQawzA6UZZQxxS2DVHK1Rahd
	ADUuSXNVCwRgEghn2n+LYmSf4eFx9/FNxcitj8fzaiOeyQYhV7kor8H2g/jzFhEm
	vGZW18hxY3keSM6U6SGy8bA1jR96GGfKidA==
X-ME-Sender: <xms:VGiFZmBck_A6JFkklqw2UGoA87eeCzXIJQVBsoLZz5UogkxO4kv9yg>
    <xme:VGiFZgixMoQpLove_4dvRxx6UKRayHEPecqcFaULC9i_K4uytEy0NUI5Og5pBx4zg
    3bLsljPyEgEez4Ke1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflrghkohgs
    ucflrghrmhgrrhdfuceojhgrkhhosgesjhgrrhhmrdgrrheqnecuggftrfgrthhtvghrnh
    epueefieffledvvddukeeltdejjefgheegveffudffvddttdegjeffueffiedtfeeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrkhhosg
    esjhgrrhhmrdgrrh
X-ME-Proxy: <xmx:VGiFZpnoYu_R13EWL5wWKKf1l7dMvuPitUbGfVZm3QXL2QFIiHY3dQ>
    <xmx:VGiFZkzrBSp6QO4LoqtcOrGuWv2HLsDrYbWC6EC1OuF4CzhB5rb9_g>
    <xmx:VGiFZrQ7P0TTJjLSiELl8RR13ABSiamFyKDxnAW1x5gPzjrJLJae9Q>
    <xmx:VGiFZva_ZoGv9GZVQ3v65ZlLek7zF-TdeZf-z9uWFF-tEUOgAoy6iA>
    <xmx:VWiFZpNEZWCSuLBFG4cajG10eZXzgyzMN5j7gjcR0QRhocIWK0PTzEdu>
Feedback-ID: ie4314728:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 290C431A0066; Wed,  3 Jul 2024 11:03:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c98ac733-0610-4305-8efb-046fe398131a@app.fastmail.com>
Date: Wed, 03 Jul 2024 17:03:27 +0200
From: "Jakob Jarmar" <jakob@jarm.ar>
To: "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Subject: Bug with --buildid-mmap?
Content-Type: text/plain

Hi,

I believe I may have found a bug in the --buildid-mmap flag for perf record,
where it hangs trying to read from /dev/dri/renderD128 trying to look up a
build ID. I can reliably reproduce it with:

perf record -p 12345 -g --call-graph=dwarf --buildid-mmap

(where 12345 is some process such that /proc/12345/maps contains
/dev/dri/renderD218)

See example backtrace (produced with GDB on the hung perf process) below.
This backtrace is from a slightly old version of perf, but the issue is present
in master on torvalds/linux (I got some compiler errors from perf-tools-next).
Apologies in advance if Fastmail lied to me and sent this as HTML.

Kind regards
Jakob Jarmar


#0  0x00007f91dc500d95 in __libc_pread64 (fd=43, buf=0x7ffda9164310, count=0, offset=<optimized out>)
    at ../sysdeps/unix/sysv/linux/pread64.c:25
#1  __libc_pread64 (fd=fd@entry=43, buf=buf@entry=0x7ffda9164310, count=count@entry=0, 
    offset=offset@entry=0) at ../sysdeps/unix/sysv/linux/pread64.c:23
#2  0x00007f91dc53824e in __pread_chk (fd=fd@entry=43, buf=buf@entry=0x7ffda9164310, 
    nbytes=nbytes@entry=0, offset=offset@entry=0, buflen=buflen@entry=64) at pread_chk.c:28
#3  0x00007f91dd40ac7c in pread (__fd=43, __buf=0x7ffda9164310, __nbytes=0, __offset=<optimized out>)
    at /usr/include/bits/unistd.h:38
#4  pread_retry (fd=43, buf=0x7ffda9164310, len=0, off=0) at ../lib/system.h:192
#5  read_unmmaped_file (fildes=43, offset=0, maxsize=0, cmd=ELF_C_READ, parent=0x0)
    at /usr/src/debug/elfutils-0.191-4.fc40.x86_64/libelf/elf_begin.c:601
#6  read_file (fildes=fildes@entry=43, offset=offset@entry=0, maxsize=<optimized out>, 
    maxsize@entry=18446744073709551615, cmd=cmd@entry=ELF_C_READ, parent=parent@entry=0x0)
    at /usr/src/debug/elfutils-0.191-4.fc40.x86_64/libelf/elf_begin.c:716
#7  0x00007f91dd40fd6f in elf_begin (fildes=fildes@entry=43, cmd=cmd@entry=ELF_C_READ, ref=ref@entry=0x0)
    at /usr/src/debug/elfutils-0.191-4.fc40.x86_64/libelf/elf_begin.c:1212
#8  0x0000560146879b86 in read_build_id (filename=0x560159d97b48 "/dev/dri/renderD128", 
    bid=0x7ffda9165490) at util/symbol-elf.c:980
#9  filename__read_build_id (filename=filename@entry=0x560159d97b48 "/dev/dri/renderD128", 
    bid=bid@entry=0x7ffda9165490) at util/symbol-elf.c:1025
#10 0x000056014682f40f in perf_record_mmap2__read_build_id (event=event@entry=0x560159d97b00, 
    machine=<optimized out>, is_kernel=is_kernel@entry=false) at util/synthetic-events.c:397
#11 0x0000560146830e2b in perf_event__synthesize_mmap_events (tool=tool@entry=0x560146fbf420 <record>, 
    event=event@entry=0x560159d97b00, pid=pid@entry=1066149, tgid=tgid@entry=1066149, 
    process=process@entry=0x5601466d07c0 <process_synthesized_event>, 
    machine=machine@entry=0x560159d72a58, mmap_data=true) at util/synthetic-events.c:529
#12 0x000056014683141c in __event__synthesize_thread (comm_event=comm_event@entry=0x560159d97ab0, 
    mmap_event=mmap_event@entry=0x560159d97b00, fork_event=fork_event@entry=0x560159d98b70, 
    namespaces_event=namespaces_event@entry=0x560159dc5bb0, pid=1066149, full=full@entry=1, 
    process=0x5601466d07c0 <process_synthesized_event>, tool=0x560146fbf420 <record>, 
    machine=0x560159d72a58, needs_mmap=true, mmap_data=true) at util/synthetic-events.c:841
#13 0x000056014683167e in __perf_event__synthesize_threads (tool=tool@entry=0x560146fbf420 <record>, 
    process=process@entry=0x5601466d07c0 <process_synthesized_event>, 
    machine=machine@entry=0x560159d72a58, needs_mmap=needs_mmap@entry=true, 
    mmap_data=mmap_data@entry=true, dirent=0x560159da0210, start=0, num=510)
    at util/synthetic-events.c:978
#14 0x0000560146831ef9 in perf_event__synthesize_threads (tool=tool@entry=0x560146fbf420 <record>, 
    process=process@entry=0x5601466d07c0 <process_synthesized_event>, 
    machine=machine@entry=0x560159d72a58, needs_mmap=true, mmap_data=<optimized out>, 
    nr_threads_synthesize=nr_threads_synthesize@entry=1) at util/synthetic-events.c:1049
#15 0x0000560146833864 in perf_event__synthesize_threads (tool=0x560146fbf420 <record>, 
    process=0x5601466d07c0 <process_synthesized_event>, machine=0x560159d72a58, 
    needs_mmap=<optimized out>, mmap_data=<optimized out>, nr_threads_synthesize=1)
    at util/synthetic-events.c:1960
#16 0x00005601466cea47 in record__synthesize (tail=tail@entry=false, rec=0x560146fbf420 <record>)
    at builtin-record.c:2135
#17 0x00005601466d21f5 in __cmd_record (argc=argc@entry=0, argv=argv@entry=0x7ffda916fe70, 
    rec=0x560146fbf420 <record>) at builtin-record.c:2536
#18 0x00005601466d567e in cmd_record (argc=<optimized out>, argv=<optimized out>)
    at builtin-record.c:4257
#19 0x000056014677edcf in run_builtin (p=p@entry=0x560146fc20e8 <commands+264>, argc=argc@entry=8, 
    argv=argv@entry=0x7ffda916fe70) at perf.c:349
#20 0x00005601466bd717 in handle_internal_command (argc=8, argv=<optimized out>) at perf.c:402
#21 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:446
#22 main (argc=<optimized out>, argv=0x7ffda916fe70) at perf.c:562
