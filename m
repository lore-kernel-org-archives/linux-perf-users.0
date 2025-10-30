Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83D223311
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832385; cv=none; b=udP1FXB27svBsr7dqcOJA0n/hep3s/pLFBdvgeXznbvACY0qwk3l4G2mvWv/Qj4IQ43khFF6YOWewAdhVJu1ywAnMAek84FI3X1rWC9cHBtepWiXWoUV8KzajA1fXEkhUMcF/pkP8KRooUVtNubOlG7Qfc59J4GFPcjAJJ4O6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832385; c=relaxed/simple;
	bh=ch9av5pawvwQYQQqqinPkuAgW5cUL52K6zwvuPZ6HzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhFmzOwR6mhLF68D7qkqC+YWYZ4rhgVWnCn1SOSEYwHEtqTe4PRIt7fcwW40qjCwVhDegyt1pzMhnTY+64ozK0FqEATlcTIb5LU6r+lOtak1NRc6QSzARwQvQ1f9BTOtu5PPJt6XJiYYRQ2f/JxRqecfgb4TMCaE/hQHioMCsHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCIcc68x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCIcc68x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761832383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UiD+9PFw/UEgLmukuI7fneU0DXWRAFm+QQ8XrA1QPRU=;
	b=hCIcc68xbSwN+UMDaNffeyTJDHSsvHWZIvDiEQmEBLeSYnPYwFTuCn2/bXw58MZdtSyax1
	JjrGJ1J/QGI6aKhU6Zl3oidpcaSBHXlpR6jcW1+0uoQqZFgZEA+GQjuT8gr8mU6NFeXOUj
	i+IdAPAjYrULmp2WJghXr+I05FW6x/U=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-1G37X9pwP0GMx3x9c2KivQ-1; Thu, 30 Oct 2025 09:53:01 -0400
X-MC-Unique: 1G37X9pwP0GMx3x9c2KivQ-1
X-Mimecast-MFC-AGG-ID: 1G37X9pwP0GMx3x9c2KivQ_1761832380
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-592f3372a26so504869e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 06:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832380; x=1762437180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiD+9PFw/UEgLmukuI7fneU0DXWRAFm+QQ8XrA1QPRU=;
        b=iHBvK6RJesJzBKA7UswYgmrTB3M4yFuSyksaCvAU6/nZ4IAKnCEGibnnB0ZIsHZR5C
         UTs/mlPHAbsVWDzMdbWZm0YFaiFbEMNHC0YyjLeAEH7CGKQdOG0zaEhwFuzhgLXcAvsq
         vfo3dlQYNpaM+SUEWfYQXQ4cT1TWcqPNAA8qeGz7MsCBHGN0HQ/N9v0ClCqRUbLTI94e
         lj3wPF8IYObrhNY89pmyfQ166F1znr+CMim+eb1vCjJtjKe+6i2okpxOquVYQlYL7IhH
         BwfYYMVduJGAnmvnHzLADtXuEBtiUC9SdG1LLE3RxANsV8z9eM7dyYDfM7gLreLJRkpW
         3PzA==
X-Forwarded-Encrypted: i=1; AJvYcCXfyku20kvORuBPetvBDCU+MSooLSF35mxE1GJ4f6x8fwiNR7QqMg25w1RebsFDgIQa9aY5XdBswWORgpVBLdsN@vger.kernel.org
X-Gm-Message-State: AOJu0YzhszokWvkwe+RbxWPXJt5yPWCl5H4k/dYVPyxV1Hy3EIol4dlj
	WeNTDm+46GpMLmfr5/5T2mlbmNH9HlTu0OU62+CXgOPZBl+dtyaK3IX/7DdFGKzamN2E9aPOdYI
	GKbxMNieD4HdV/oPmtICSPZp6XqbdFaVx+F8XQQ79y4GsNMCqeNG6Rbb7oNXkFezCemtmeHE7pm
	yPes/5sNjPKhGoZuOuIHgGEO1zIX4AWIL+UFpvJ2KXFmR8vQ==
X-Gm-Gg: ASbGncsG+2uGaWJNJCWanGMlSwdNzWTAP6FeM7hSTdjh56whAxwPVILtTepXcR5i4jG
	vP10ybqC2iiLGPSPPyypzrAhkwLprRteuQaI0KgHZsXRH9QwGhlRJfesnA6t9TRoN0mFSdaHTcw
	r0LtUV2c4huzs/TVBb8uOXslSYLkmcUfG8pz8ZsbkChYcMrtWnX4BCYA==
X-Received: by 2002:a05:6512:660e:b0:594:1d20:22e8 with SMTP id 2adb3069b0e04-5941d202940mr9522e87.37.1761832379896;
        Thu, 30 Oct 2025 06:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3I0ZK5UyhQXE6WtqxOhmH2il+0opqitZKwbOTT+UIO22pJyBr+OX/7QUH2gGidAgQyY0KfY3CMYIdOfO8vAo=
X-Received: by 2002:a05:6512:660e:b0:594:1d20:22e8 with SMTP id
 2adb3069b0e04-5941d202940mr9518e87.37.1761832379423; Thu, 30 Oct 2025
 06:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132406.78359-2-ashelat@redhat.com> <5b02372a-f0be-4d3a-a875-c5ea65f2bafe@linux.ibm.com>
 <CA+G8Dh+DaVp1XVHm=Hh1aLP=5YOmChTRu4=nSUAwTKJO-a4LDw@mail.gmail.com>
 <f674d1eb-c492-4dec-a49c-8b40833741a4@linaro.org> <2e756e75-7dc9-4838-8651-ca1a0f056966@linux.ibm.com>
In-Reply-To: <2e756e75-7dc9-4838-8651-ca1a0f056966@linux.ibm.com>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 30 Oct 2025 13:52:48 +0000
X-Gm-Features: AWmQ_bmn0Wz5Mm0lC5uunzkfDLWG-g3sdVrG8lhFv0Wvn27zZm_LqJkWs9XuI6M
Message-ID: <CA+G8DhKTpZLzRbZvGiS6YZxOXecEcrtOUcNdHOpjDM9Cz0qzxg@mail.gmail.com>
Subject: Re: [PATCH] Revert "perf test: Allow tolerance for leader sampling test"
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: James Clark <james.clark@linaro.org>, mpetlan@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, irogers@google.com, linux-perf-users@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, dapeng1.mi@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

> On 10/28/25 12:30, James Clark wrote:
> > You mentioned on the other thread that it's failing "differently", can you expand on that? I'm wondering why you sent the revert patch then?
The issue was that for every (leader, sibling) event pair there was an
18 cycle difference between the sibling and the leader. Initially I
thought that this was fixed by the group throttle fixing patch
(9734e25fbf5a), but I just got a VM running 6.12.0-145.el10.aarch64
which is up to date with v6.16 and it has that bug.
I want to revert the patch since the bug it exists for has been fixed,
and as you mentioned it could be silencing other bugs. Since I'm able
to reprouce Thomas's issue on an arm machine it seems like this is not
a hardware issue inherent to s390x and there's no reason for this
patch to be in the kernel anymore.

> > As I mentioned before I'm not seeing any issues. Can you share the kernel version that you tested on and your kernel config? And can you share the same outputs that I asked Thomas for below please.
For the system experiencing the 18 cycle difference bug:
Linux ampere-mtsnow-altramax-03-vm-13.lab.eng.rdu2.redhat.com
6.12.0-145.el10.aarch64 #1 SMP PREEMPT_DYNAMIC Fri Oct 24 12:39:51 UTC
2025 aarch64 GNU/Linux
[root@ampere-mtsnow-altramax-03-vm-13 ~]# perf script | head -30
            perf   91202 168884.094165:        146 cycles:
ffff9e94ba40 _start+0x0 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094165:        164 cycles:
ffff9e94ba40 _start+0x0 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094188:         74 cycles:
ffffc6fe45649728 [unknown] ([unknown])
            perf   91202 168884.094188:         74 cycles:
ffffc6fe45649728 [unknown] ([unknown])
            perf   91202 168884.094213:        134 cycles:
ffff9e94ba40 _start+0x0 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094213:        152 cycles:
ffff9e94ba40 _start+0x0 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094233:        136 cycles:
ffff9e9473cc _dl_start+0x0 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094233:        154 cycles:
ffff9e9473cc _dl_start+0x0 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094252:        293 cycles:
ffffc6fe45648e18 [unknown] ([unknown])
            perf   91202 168884.094252:        293 cycles:
ffffc6fe45648e18 [unknown] ([unknown])
            perf   91202 168884.094273:        275 cycles:
ffff9e9473fc _dl_start+0x30 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094273:        293 cycles:
ffff9e9473fc _dl_start+0x30 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094291:         56 cycles:
ffffc6fe45648e18 [unknown] ([unknown])
            perf   91202 168884.094291:         56 cycles:
ffffc6fe45648e18 [unknown] ([unknown])
            perf   91202 168884.094312:       1138 cycles:
ffff9e947400 _dl_start+0x34 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094312:       1156 cycles:
ffff9e947400 _dl_start+0x34 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094336:        414 cycles:
ffff9e947454 _dl_start+0x88 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094336:        432 cycles:
ffff9e947454 _dl_start+0x88 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094355:        692 cycles:
ffff9e947444 _dl_start+0x78 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094355:        710 cycles:
ffff9e947444 _dl_start+0x78 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094379:       1328 cycles:
ffffc6fe45648e18 [unknown] ([unknown])
            perf   91202 168884.094379:       1328 cycles:
ffffc6fe45648e18 [unknown] ([unknown])
            perf   91202 168884.094403:       3871 cycles:
ffff9e941550 __GI___tunables_init+0xd0
(/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094403:       3889 cycles:
ffff9e941550 __GI___tunables_init+0xd0
(/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094425:       7787 cycles:
ffff9e94153c __GI___tunables_init+0xbc
(/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094425:       7805 cycles:
ffff9e94153c __GI___tunables_init+0xbc
(/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094464:      17320 cycles:
ffff9e94c794 __set_vma_name+0x54 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094464:      17338 cycles:
ffff9e94c794 __set_vma_name+0x54 (/usr/lib/ld-linux-aarch64.so.1)
            perf   91202 168884.094606:      38889 cycles:
ffffc6fe45649bcc [unknown] ([unknown])
            perf   91202 168884.094606:      38889 cycles:
ffffc6fe45649bcc [unknown] ([unknown])

For the first mismatching sample:
[root@ampere-mtsnow-altramax-03-vm-13 ~]# perf report -D | grep
ffff9e94ba40 -A 8
168884094165520 0x6a0 [0x68]: PERF_RECORD_SAMPLE(IP, 0x2):
91202/91202: 0xffff9e94ba40 period: 1 addr: 0
... sample_read:
.... group nr 2
..... id 000000000000002c, value 0000000000000092, lost 0
..... id 0000000000000034, value 00000000000000a4, lost 0
 ... thread: perf:91202
 ...... dso: /usr/lib/ld-linux-aarch64.so.1
 ... thread: perf:91202
 ...... dso: /usr/lib/ld-linux-aarch64.so.1
--
168884094213520 0x770 [0x68]: PERF_RECORD_SAMPLE(IP, 0x2):
91202/91202: 0xffff9e94ba40 period: 1 addr: 0
... sample_read:
.... group nr 2
..... id 000000000000002c, value 0000000000000162, lost 0
..... id 0000000000000034, value 0000000000000186, lost 0
 ... thread: perf:91202
 ...... dso: /usr/lib/ld-linux-aarch64.so.1
 ... thread: perf:91202
 ...... dso: /usr/lib/ld-linux-aarch64.so.1

For the first matching sample:
[root@ampere-mtsnow-altramax-03-vm-13 ~]# perf report -D | grep
ffffc6fe45649728 -A 8
168884094188520 0x708 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
91202/91202: 0xffffc6fe45649728 period: 1 addr: 0
... sample_read:
.... group nr 2
..... id 000000000000002c, value 00000000000000dc, lost 0
..... id 0000000000000034, value 00000000000000ee, lost 0
 ... thread: perf:91202
 ...... dso: <not found>
 ... thread: perf:91202
 ...... dso: <not found>


I also was able to get a bare metal arm machine with the same kernel
version: Linux ampere-mtsnow-altra-01.khw.eng.rdu2.dc.redhat.com
6.12.0-145.el10.aarch64 #1 SMP PREEMPT_DYNAMIC Fri Oct 24 12:39:51 UTC
2025 aarch64 GNU/Linux. On this machine I wasn't able to reproduce any
issue. I'm trying to get another vm to reproduce Thomas' issue again.

Anubhav

