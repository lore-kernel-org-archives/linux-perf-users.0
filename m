Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E439A2D5C74
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773037026; cv=none; b=TA/G5wtx5w2+7lwlYRaL8GAVBhm3LLLH5F2nvsQhH19wG5w10NmZhL+CXiq/J9uTTgU05vdSjFo4vk+9r9y9bOrYC88XlbFfxQgVatlL8++lYuj1RT6bQGHbBkNK/JweEPJ0Z/Scr5iggRJrsLMjB8x2LJBZN3AFtPit8g352JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773037026; c=relaxed/simple;
	bh=ERgUe/+FzTOe9WmhcAD2Kl8K2CxRVSBOeldW5TuwqME=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RRagqk2swgTECZc0SYecd/ia+/rYjVITL+Ies1X2SUb2KRvKVcS87H65mpvOFfu7IgnNdcgisUHBo0L5DoW/045POfiQoDKcCeUp6NOOJrScOi7dMCZVQnxWYPdpI9NAK8iTtazfIeZs1IjERm5dI+SWOcQ0SaK5nq5Y2PTqn08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679c5ed0942so128517443eaf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Mar 2026 23:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773037024; x=1773641824;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BqFR7Gsjt7d2ME1+11+TLKge1wAdWjjWXBZijskabM=;
        b=T4cpYqTA4rOra9DFInXnTuOEs4BqVqLFtWBR2f4ePQ+9xR7LtSeKS74AvbGjKvfbYv
         1VUICaHHXvR8AECjZ3PJci+PSMs7PY48IAM/RO237qmT8iOKSa8JEqSQdOznKGhvOZ2N
         +MFJz+iUloIcxBsU4GruyBedldlr0pe8G+tnIFaN8U9aYYRs+jTjCp1ZMgKOli2WgXt3
         k4vowIefOiBy+BC1Gx4JrdLqiKjtZyI+EfGwrxPHAZWvbABK/X3mx50jJ0EQGVZi8Qzu
         4u2D9o05hgXdr6+6ZIy5N0BplBpKfcFfAVOlC0mj361+mdyorZL0+rWzrJOnQFjjE9bU
         mmFA==
X-Forwarded-Encrypted: i=1; AJvYcCWS0UByoOXOdNWh0tSwfsehTzetiEf+Dx+Ny7uT1iXRDu3amQLRnle1aLbfs255Muo9v/kiuyi3A+bdjqr2d7W/@vger.kernel.org
X-Gm-Message-State: AOJu0YzmcMG6Paiw8CT+EUrl8FkHzJbQ7/A9EhH4R4XtJ/oRjJ3bMYfZ
	6S6K2808ig4yhomCqwamlj5Q01EeRCLJ3cIj0tBJd2NssMYvboXNqXriOZPmb9LujAGeNHGMDyq
	KkALJ5sCkmwZRSmwZu+hYeJLQO0LaYUM0+S1Yw9WzuiT7eaGlpjjpmiirDNk=
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:468d:b0:67b:b8d0:a7d5 with SMTP id
 006d021491bc7-67bb8d0acaamr11752eaf.53.1773037023936; Sun, 08 Mar 2026
 23:17:03 -0700 (PDT)
Date: Sun, 08 Mar 2026 23:17:03 -0700
In-Reply-To: <20260309055713.1938024-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ae65df.050a0220.310d8.0017.GAE@google.com>
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

failed to copy syz-executor to VM: failed to run ["scp" "-P" "41992" "-F" "=
/dev/null" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "IdentitiesOnly=3Dyes=
" "-o" "BatchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o" "ConnectTim=
eout=3D10" "/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/bi=
n/linux_amd64/syz-executor" "root@localhost:/syz-executor"]: exit status 1



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
 -ffile-prefix-map=3D/tmp/go-build1130506223=3D/tmp/go-build -gno-record-gc=
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
/usr/bin/ld: /tmp/cc2iNFRL.o: in function `Connection::Connect(char const*,=
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D130d03aa5800=
00

