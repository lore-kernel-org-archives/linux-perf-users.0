Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172B358D3D
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038403; cv=none; b=pXdWN7Y7VutHBa4ouxKRPLNoYGLtoOLCcNe7gRM5G4MwY7OQYM3Fehwo9VvYpIgfcmpMLDXu9iwZgnerbIBRsLO9mDI2r6GQk71aK5D0SoVaXKEg6soatO+venVbCpSfQwsT7T4yRfoT7kMeKdhVHzjNp7yKxhf60pL8qniLebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038403; c=relaxed/simple;
	bh=Kzc1Dfnf6B37TRai5P1OP7X+ximK8MJZzyjecSdOZ/A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i07qQimmQf4VUmQQNHtEmUMkshhQNhXgjaK51ODyOEcKC5AsJ/8ZwuoJavwhL8MKjDXm5qWXpMUY73kRke1kZth8aV466pe52Q3VM4rVigtjagZeQ+nud/FE2FepvgKbNor3FUwvbxOu33qX4AFZnWKV3zzYRA0EhlXlSie5wBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67ba8d8546cso25820075eaf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Mar 2026 23:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773038401; x=1773643201;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4V8Az87Ee8miJje6kJFN+wnux8gIfhO+zur5wo6BnCw=;
        b=LS2j3HQZEmLSCdRjQ8Yh5dgOgGJIQLDfigUrNkMGdi9H1PEQn1dA1xS96EBWKQkXyS
         F4E0yfxLuugai761F2jAB8GXL8hpqJH8DUWouMYb4lm2W9Cv8bBuzU5Wg1oMBsaSD0+S
         9emXZwTI83N8BJZ1wE+C/DSf2BTdhCBq4bbcB8/2EIZihvJCLXRUIWE1KnHHcfqWsIOu
         0NOn6+RS3UMVrdfi+5Fcv5HCFnpn9avPK4fDJTA1dOvEtD+zxKTbQOXjjRR7v6fLCMe/
         2FTAzkOPBJJLaBbLIoQNVneI7hKBbtDFwfrOOk0lj0qI24ItNhoPe4eMceiuX+mfZ8iX
         Yi1w==
X-Forwarded-Encrypted: i=1; AJvYcCWAKnff5oP71yFsdUNR1BxwUyQaKLzaW3qnY8Giv6Sr5DSsjCoWZfax/e8Tges4cbkkxISfWLjZBnqQubJyHvyy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5wqgFqYjoi4seKu/75QE0tSPaUG5MFhu8AO3PNVBS8gHksG/
	2afY1tMLV/CDtTrJ9+eP0k13qUofKsd4ceIliHajNJkaMOld/CUrrMuXB00jU9154pXCeRZ+5pl
	dpWo6vRhIjGGdyHwyN+ahxAMwgBdCVGy2w8aeZVCHfjfolovf0SC+bXg1Qpc=
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:22a5:b0:67a:1cf1:a409 with SMTP id
 006d021491bc7-67b9bd6c430mr6628374eaf.76.1773038401317; Sun, 08 Mar 2026
 23:40:01 -0700 (PDT)
Date: Sun, 08 Mar 2026 23:40:01 -0700
In-Reply-To: <20260309062223.1953399-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ae6b41.050a0220.310d8.0018.GAE@google.com>
Subject: Re: [syzbot] [perf?] possible deadlock in refcount_dec_and_mutex_lock (2)
From: syzbot <syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

lost connection to test machine



syzkaller login: [   97.295165][    T9] cfg80211: failed to load regulatory=
.db
qemu-system-x86_64: ahci: PRDT length for NCQ command (0x0) is smaller than=
 the requested size (0xaf000)
qemu-system-x86_64: ahci: PRDT length for NCQ command (0x0) is smaller than=
 the requested size (0x400000)
Warning: Permanently added '[localhost]:25860' (ED25519) to the list of kno=
wn hosts.
2026/03/09 06:38:40 parsed 1 programs
[  114.832215][ T5312] cgroup: Unknown subsys name 'net'
[  114.886131][ T5312] cgroup: Unknown subsys name 'cpuset'
[  114.893161][ T5312] cgroup: Unknown subsys name 'rlimit'
[  143.365998][ T1314] ieee802154 phy0 wpan0: encryption failed: -22
[  143.369198][ T1314] ieee802154 phy1 wpan1: encryption failed: -22
[  166.421433][ T1009] ata1.00: NCQ disabled due to excessive errors
[  166.425080][ T1009] ata1.00: exception Emask 0x0 SAct 0x1004000 SErr 0x0=
 action 0x6 frozen
[  166.429465][ T1009] ata1.00: failed command: WRITE FPDMA QUEUED
[  166.433585][ T1009] ata1.00: cmd 61/78:70:2e:60:04/05:00:00:00:00/40 tag=
 14 ncq dma 716800 out
[  166.433585][ T1009]          res 40/00:00:00:00:00/00:00:00:00:00/00 Ema=
sk 0x4 (timeout)
[  166.443249][ T1009] ata1.00: status: { DRDY }
[  166.445372][ T1009] ata1.00: failed command: WRITE FPDMA QUEUED
[  166.448286][ T1009] ata1.00: cmd 61/00:c0:be:89:04/20:00:00:00:00/40 tag=
 24 ncq dma 4194304 ou
[  166.448286][ T1009]          res 40/00:00:00:00:00/00:00:00:00:00/00 Ema=
sk 0x4 (timeout)
[  166.458365][ T1009] ata1.00: status: { DRDY }
[  166.460620][ T1009] ata1: hard resetting link
[  166.785912][ T1009] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 30=
0)
[  166.790793][ T1009] ata1.00: configured for UDMA/100
[  166.794045][ T1009] ata1: EH complete
qemu-system-x86_64: hw/ide/core.c:934: ide_dma_cb: Assertion `prep_size >=
=3D 0 && prep_size <=3D n * 512' failed.
Connection to localhost closed by remote host.


syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build1821029113=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.26.0'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at 41d8037d3362
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3D41d8037d336239d16aac70cd8cd917b77068d00b -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20260306-090128"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3D41d8037d336239d16aac70cd8cd917b77068d00b -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20260306-090128"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D41d8037d336239d16aac70cd8cd917b77068d00b -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20260306-090128"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"41d8037d336239d16aac70cd8cd917b770=
68d00b\"
/usr/bin/ld: /tmp/ccmKTIy0.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x386): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null



Tested on:

commit:         1f318b96 Linux 7.0-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc5c49ee0942d1cd=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3D196a82fd904572696=
b3c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-=
1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16d178d65800=
00

