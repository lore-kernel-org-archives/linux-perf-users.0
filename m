Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CC6C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Jun 2022 19:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiFQTp1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Jun 2022 15:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiFQTpZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Jun 2022 15:45:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB58657B34
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jun 2022 12:45:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z17so2795360wmi.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jun 2022 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RUMTIYMVP2pmExLEc/bhtLPOhxI6XF2GBAXgPSD8VGw=;
        b=F54tySywij7QxA8gUbru1FEcwV2CxXL9iqqZn2b4qoeMHdZ+8Sx642agzOpQsV7mL5
         QrSyKZPPjxKY3hj55wiW93rihT6Ci14649GgpJOt7hxmqwk7WujRa8UIDEvIeMCJp5Di
         Thkfv38OMKrp/i03PRpTj52vppu+k9dAvokK3YlyK+74DMnxuZcC6ihBHZTsSZAQ/deI
         9MUUhjLrVI+tDR9H5qYfl3xMSwGTivbH8n4nsCNw/iKimp9Q7W2QLPybpf/zgNdu06LR
         9hMX3FcG8LaLMr/oqcy6TkpzW5xvnbQFEOxX2zjEXfcQ2ArQk5AK4S6OrQfGTa55JJCS
         Eg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RUMTIYMVP2pmExLEc/bhtLPOhxI6XF2GBAXgPSD8VGw=;
        b=lieHAr3t79wqXDbXCWPE7cniEk+BzhTiz6L7vh9SPENjpw2fFTRvekbxzOl5urJU99
         DFCMRTsNyRlr1kEIjJgjPngX8XLt86MNzUBImXOTugxfIZk+4UP4Fh4GhwUMvkHfLi6Z
         ObPheHtz+F6yA5yFNBvF9yvCstVT7GxydtSQCso1z7enOdbgTaBItJOijkx+i/PciEUf
         cpU2z5Ywh3n1H4vo8pZU7jApduXm1YRTgwkrVnmYrgc5EMbstyyPUYk3REqk7K7rXgKE
         Bdvz5NZkV8k5CL+kUTRiq0SVgVT0lVhgef6xaR6Bm3gtdxviS6xNWjSDZJ/Z2ONZRE5v
         4Mog==
X-Gm-Message-State: AJIora8gASNMQrWzFdpca34l+h8cNVNrhQdUb02vobmjSGVeklkEynzl
        iKqLgjPaHaMXVB/9seQZNYI8OFzp9Iq7RFPHmS7Pww==
X-Google-Smtp-Source: AGRyM1tBh+J/rtcPs0XJ1G+dNb7YqUdt8ggZnYEyAlgzGSyGrAd4O6HvLrgtcrNWlhatb/FYswlh9BxAoABlkMS+01I=
X-Received: by 2002:a05:600c:29d3:b0:397:4730:ee75 with SMTP id
 s19-20020a05600c29d300b003974730ee75mr11703861wmd.149.1655495119882; Fri, 17
 Jun 2022 12:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045AqOtn4dbMNnTvNB=2WNVKVRTeshm1jVk2kYPsA9Vmj=jw@mail.gmail.com>
 <CAP-5=fU6Jk1+hZARCPjp34jQLo0n+=mLpcPGcR_2uwOLwHX3Dg@mail.gmail.com> <YqzT40KoS5bnIt88@kernel.org>
In-Reply-To: <YqzT40KoS5bnIt88@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 17 Jun 2022 12:45:07 -0700
Message-ID: <CAP-5=fWw+u_kidPzhRmMzh2izgxOupxJKKsao=ATEZJUR8C3qg@mail.gmail.com>
Subject: Re: Why isn't the augmented_raw_syscalls functionality included in
 `perf trace` by default?
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 17, 2022 at 12:20 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jun 15, 2022 at 10:16:09AM -0700, Ian Rogers escreveu:
> > On Wed, Jun 15, 2022 at 9:44 AM Kyle Huey <me@kylehuey.com> wrote:
> > > Printing of filenames especially is a massive improvement over the
> > > output of plain `perf trace`.  Is there a reason this isn't included
> > > in the main `perf trace` command?
> >
> > It can be tricky for tools to get things like file names as a pointer
> > may be to unreadable memory, paged out memory, etc. Perf trace does
> > support adding this information by way of libaudit but we've proposed
>
> Humm? 'perf trace' only used libaudit to map syscall ids to names (which
> is not the case since we introduced
> tools/perf/arch/x86/entry/syscalls/syscalltbl.sh and equivalent on the
> other arches, starting back in 2016) and for ERRNO id->name (which is
> not the case since tools/perf/trace/beauty/arch_errno_names.sh was added
> by Hendrik back in 2018).
>
> To get pointer contents, such as pathnames and some structs by using the
> augmented_raw_syscalls.c code (originally introduced as
> augmented_syscalls.c, back in August, 2018), which is indeed eBPF, being
> one of the first users of libbpf, in fact libbpf changes were made to
> support perf trace eBPF support.
>
> One can use it as an opensnoop tool, see:
>
> [root@quaco ~]# perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augm=
ented_raw_syscalls.c --max-events 32 -e open*
>      0.000 gpm/1017 openat(dfd: CWD, filename: "/dev/tty0", flags: RDONLY=
) =3D 4
>     54.113 systemd-oomd/948 openat(dfd: CWD, filename: "/proc/meminfo", f=
lags: RDONLY|CLOEXEC) ...
>     54.220 abrt-dump-jour/1337 openat(dfd: CWD, filename: "/var/log/journ=
al/d6a97235307247e09f13f326fb607e3c/system.journal", flags: RDONLY|CLOEXEC|=
NONBLOCK) =3D 32
>     54.113 systemd-oomd/948  ... [continued]: openat())             =3D 1=
2
>     54.282 abrt-dump-jour/1336 openat(dfd: CWD, filename: "/var/log/journ=
al/d6a97235307247e09f13f326fb607e3c/system.journal", flags: RDONLY|CLOEXEC|=
NONBLOCK) =3D 32
>     54.294 abrt-dump-jour/1338 openat(dfd: CWD, filename: "/var/log/journ=
al/d6a97235307247e09f13f326fb607e3c/system.journal", flags: RDONLY|CLOEXEC|=
NONBLOCK) =3D 32
>    101.745 gnome-terminal/2987 openat(dfd: CWD, filename: "/proc/557621/c=
mdline", flags: RDONLY) =3D 25
>    202.308 sh/761448 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags=
: RDONLY|CLOEXEC) =3D 3
>    202.415 sh/761448 openat(dfd: CWD, filename: "/lib64/libtinfo.so.6", f=
lags: RDONLY|CLOEXEC) =3D 3
>    202.572 sh/761448 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags=
: RDONLY|CLOEXEC) =3D 3
>    203.772 sh/761448 openat(dfd: CWD, filename: "", flags: RDWR|NONBLOCK)=
 =3D 3
>    203.772 sh/761448  ... [continued]: openat())             =3D 3
>    204.155 sh/761448 openat(dfd: CWD, filename: "/usr/lib64/gconv/gconv-m=
odules.cache", flags: RDONLY) =3D 3
>    206.797 procmail/761448 openat(dfd: CWD, filename: "/etc/ld.so.cache",=
 flags: RDONLY|CLOEXEC) =3D 3
>    206.901 procmail/761448 openat(dfd: CWD, filename: "/lib64/libm.so.6",=
 flags: RDONLY|CLOEXEC) =3D 3
>    207.042 procmail/761448 openat(dfd: CWD, filename: "/lib64/libc.so.6",=
 flags: RDONLY|CLOEXEC) =3D 3
>    207.334 procmail/761448 openat(dfd: CWD, filename: "/etc/nsswitch.conf=
", flags: RDONLY|CLOEXEC) =3D 3
>    207.385 procmail/761448 openat(dfd: CWD, filename: "/etc/passwd", flag=
s: RDONLY|CLOEXEC) =3D 3
>    207.418 procmail/761448 openat(dfd: CWD, filename: "/dev/null", flags:=
 APPEND|CREAT|WRONLY, mode: IRUGO|IWUGO|IXOTH) =3D 1
>    207.516 procmail/761448 openat(dfd: CWD, filename: "/etc/services", fl=
ags: RDONLY|CLOEXEC) =3D 5
>    207.611 procmail/761448 openat(dfd: CWD, filename: "/etc/host.conf", f=
lags: RDONLY|CLOEXEC) =3D 5
>    207.630 procmail/761448 openat(dfd: CWD, filename: "/etc/resolv.conf",=
 flags: RDONLY|CLOEXEC) =3D 5
>    207.653 procmail/761448 openat(dfd: CWD, filename: "/etc/hosts", flags=
: RDONLY|CLOEXEC) =3D 5
>    207.689 procmail/761448 openat(dfd: CWD, filename: "/etc/localtime", f=
lags: RDONLY|CLOEXEC) =3D 5
>    304.129 systemd-oomd/948 openat(dfd: CWD, filename: "/proc/meminfo", f=
lags: RDONLY|CLOEXEC) =3D 12
>    402.006 procmail/761448 openat(dfd: CWD, filename: "/etc/passwd", flag=
s: RDONLY|CLOEXEC) =3D 5
>    402.294 procmail/761448 openat(dfd: CWD, filename: "/etc/procmailrc", =
flags: RDONLY) =3D -1 ENOENT (No such file or directory)
>    402.382 procmail/761448 openat(dfd: CWD, filename: "/home/acme/.procma=
ilrc", flags: RDONLY) =3D 5
>    402.501 procmail/761448 openat(dfd: CWD, filename: ".procmail.log", fl=
ags: APPEND|CREAT|WRONLY, mode: IRUGO|IWUGO|IXOTH) =3D 6
>    402.614 procmail/761448 openat(dfd: CWD, filename: "_o55C.prMriB.quaco=
", flags: CREAT|EXCL|WRONLY, mode: IRUGO) =3D 6
>    403.111 DNS Res~ver #3/566719 openat(dfd: CWD, filename: "/etc/hosts",=
 flags: RDONLY|CLOEXEC) =3D 122
>    404.484 formail/761449 openat(dfd: CWD, filename: "/etc/ld.so.cache", =
flags: RDONLY|CLOEXEC) =3D 3
> [root@quaco ~]#
>
> And in fact 'perf trace' will use some heuristics to apply that
> beautifier to path/file names:
>
> [root@quaco ~]# perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augm=
ented_raw_syscalls.c,$(echo `grep path /sys/kernel/tracing/events/syscalls/=
sys_enter_*/format | cut -d'/' -f7 | sed s/sys_enter_//g | uniq` | sed 's/ =
/,/g')
>      0.000 :763371/763371 unlink(pathname: "_rX6C.NzMriB.quaco")  =3D 0
>      7.054 :763371/763371 unlink(pathname: "msgid.lock")          =3D 0
>      8.302 :763371/763371 unlink(pathname: "lkml/_rX6C,NzMriB.quaco") =3D=
 0
>     15.176 :763371/763371 unlink(pathname: "lkml/tmp/1655491789.763371_2.=
quaco") =3D 0
>     15.238 :763371/763371 unlink(pathname: "lkml/.lock")          =3D 0
>    824.160 procmail/763373 unlink(pathname: "_tX6C.NzMriB.quaco")  =3D 0
>    830.396 fetchmail/763373 unlink(pathname: "msgid.lock")          =3D 0
>    902.746 iceccd/1162 statfs(pathname: "/var/cache/icecream", buf: 0x7ff=
eda7437b0) =3D 0
>   1166.240 IndexedDB #285/762916 statfs(pathname: "/home/acme/.mozilla/fi=
refox/7sbuc7kl.default-1636637603014/storage/default/https+++web.whatsapp.c=
om/idb/3166453069wcaw.sqlite", buf: 0x7f9307ffe250) =3D 0
>   1640.174 procmail/763377 unlink(pathname: "_xX6C.OzMriB.quaco")  =3D 0
>   1651.928 procmail/763377 unlink(pathname: "msgid.lock")          =3D 0
>   1656.910 procmail/763377 unlink(pathname: "lkml/_xX6C,OzMriB.quaco") =
=3D 0
>   1664.371 procmail/763377 unlink(pathname: "lkml/tmp/1655491790.763377_2=
.quaco") =3D 0
>   1664.454 procmail/763377 unlink(pathname: "lkml/.lock")          =3D 0
>   1665.449 gmain/2725 inotify_add_watch(fd: 11, pathname: "/var/lib/flatp=
ak/exports/share", mask: 16789454) =3D -1 ENOENT (No such file or directory=
)
>   1665.508 gmain/2725 inotify_add_watch(fd: 11, pathname: "/home/acme/.lo=
cal/share/flatpak/exports/share", mask: 16789454) =3D -1 ENOENT (No such fi=
le or directory)
>   1665.779 gmain/2737 inotify_add_watch(fd: 27, pathname: "/home/acme/.co=
nfig/firewall", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1666.378 gmain/2617 inotify_add_watch(fd: 3, pathname: "", mask: 167894=
54) =3D -1 ENOENT (No such file or directory)
>   1666.434 gmain/2617 inotify_add_watch(fd: 3, pathname: "/var/lib/app-in=
fo", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1666.461 gmain/2617 inotify_add_watch(fd: 3, pathname: "/var/lib/app-in=
fo", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1666.477 gmain/2617 inotify_add_watch(fd: 3, pathname: "/var/lib/app-in=
fo", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1666.493 gmain/2617 inotify_add_watch(fd: 3, pathname: "/var/lib/swcata=
log", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1666.509 gmain/2617 inotify_add_watch(fd: 3, pathname: "/var/lib/swcata=
log", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1666.382 gmain/2497 inotify_add_watch(fd: 7, pathname: "/home/acme/~/.c=
onfig/ibus-anthy", mask: 16789454) ...
>   1666.413 gmain/354910 inotify_add_watch(fd: 17, pathname: "/var/lib/fla=
tpak/exports/share", mask: 16789454) =3D -1 ENOENT (No such file or directo=
ry)
>   1666.460 gmain/354910 inotify_add_watch(fd: 17, pathname: "/home/acme/.=
local/share/flatpak/exports/share", mask: 16789454) =3D -1 ENOENT (No such =
file or directory)
>   1666.379 gmain/2700 inotify_add_watch(fd: 10, pathname: "/run/user/1000=
/.flatpak", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1666.417 gmain/2209 inotify_add_watch(fd: 48, pathname: "/var/lib/snapd=
/desktop/desktop-directories", mask: 16789454) =3D -1 ENOENT (No such file =
or directory)
>   1666.463 gmain/2209 inotify_add_watch(fd: 48, pathname: "/usr/local/sha=
re/desktop-directories", mask: 16789454) =3D -1 ENOENT (No such file or dir=
ectory)
>   1666.490 gmain/2209 inotify_add_watch(fd: 48, pathname: "/var/lib/flatp=
ak/exports/share/desktop-directories", mask: 16789454) =3D -1 ENOENT (No su=
ch file or directory)
>   1666.512 gmain/2209 inotify_add_watch(fd: 48, pathname: "/home/acme/.lo=
cal/share/flatpak/exports/share/desktop-directories", mask: 16789454) =3D -=
1 ENOENT (No such file or directory)
>   1666.382 gmain/2497  ... [continued]: inotify_add_watch())  =3D -1 ENOE=
NT (No such file or directory)
>   1666.644 gmain/2497 inotify_add_watch(fd: 7, pathname: "/home/acme/~", =
mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1666.456 gmain/2771 inotify_add_watch(fd: 14, pathname: "/var/lib/flatp=
ak/exports/share", mask: 16789454) =3D -1 ENOENT (No such file or directory=
)
>   1666.485 gmain/2771 inotify_add_watch(fd: 14, pathname: "/home/acme/.lo=
cal/share/flatpak/exports/share", mask: 16789454) =3D -1 ENOENT (No such fi=
le or directory)
>   1725.419 gmain/1079 inotify_add_watch(fd: 13, pathname: "/etc/NetworkMa=
nager/VPN", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1725.406 gmain/1675 inotify_add_watch(fd: 10, pathname: "/etc/distro.re=
pos.d", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1725.455 gmain/1675 inotify_add_watch(fd: 10, pathname: "/etc/yum/repos=
.d", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1725.973 gmain/707838 inotify_add_watch(fd: 4, pathname: "/var/lib/fwup=
d/metadata/lvfs-testing", mask: 16789454) =3D -1 ENOENT (No such file or di=
rectory)
>   1726.024 gmain/707838 inotify_add_watch(fd: 4, pathname: "/var/lib/fwup=
d/local.d", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1726.046 gmain/707838 inotify_add_watch(fd: 4, pathname: "/usr/share/fw=
upd/local.d", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   1726.068 gmain/707838 inotify_add_watch(fd: 4, pathname: "/var/etc/fwup=
d", mask: 16789454) =3D -1 ENOENT (No such file or directory)
>   2474.584 procmail/763379 unlink(pathname: "_zX6C.PzMriB.quaco")  =3D 0
>   2482.725 fetchmail/763379 unlink(pathname: "msgid.lock")          =3D 0
>   2484.291 fetchmail/763379 unlink(pathname: "lkml/_zX6C,PzMriB.quaco") =
=3D 0
>   2491.056 fetchmail/763379 unlink(pathname: "lkml/tmp/1655491791.763379_=
2.quaco") =3D 0
>   2491.090 fetchmail/763379 unlink(pathname: "lkml/.lock")          =3D 0
>   2662.260 BgIOThr~ol #11/747565 mkdir(pathname: "/home/acme/.mozilla/fir=
efox/7sbuc7kl.default-1636637603014/sessionstore-backups", mode: IRUGO|IXUG=
O|IWUSR) =3D -1 EEXIST (File exists)
>   2840.103 IndexedDB #285/761695 unlink(pathname: "/home/acme/.mozilla/fi=
refox/7sbuc7kl.default-1636637603014/storage/default/https+++twitter.com/id=
b/1046228012scyn.sqlite-wal") =3D 0
> ^C[root@quaco ~]#
>
> And it even supports .o files, to avoid having to compile the .c over
> and over again:
>
> [root@quaco ~]# cat ~/.perfconfig
> # this file is auto-generated.
> [llvm]
>         dump-obj =3D true # <--------------------------------------------=
-------
>         clang-opt =3D -g
> [trace]
>         show_zeros =3D yes
>         show_duration =3D no
>         no_inherit =3D yes
>         args_alignment =3D 40
> [annotate]
>         hide_src_code =3D false
> [root@quaco ~]#
>
> [root@quaco ~]# ls ~acme/git/perf/tools/perf/examples/bpf/augmented_raw_s=
yscalls.o
> /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
> [root@quaco ~]# file ~acme/git/perf/tools/perf/examples/bpf/augmented_raw=
_syscalls.o
> /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o: ELF=
 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not strip=
ped
> [root@quaco ~]# size ~acme/git/perf/tools/perf/examples/bpf/augmented_raw=
_syscalls.o
>    text    data     bss     dec     hex filename
>    2696    8508       0   11204    2bc4 /home/acme/git/perf/tools/perf/ex=
amples/bpf/augmented_raw_syscalls.o
> [root@quaco ~]#
>
> So lets replace that .c with a .o to use the eBPF bytecode directly, no
> need for clang to be installed:
>
>                                                                          =
                   |
>                                                                          =
                   |
>                                                                          =
                   |
>                                                                          =
                   |
>                                                                          =
                   |
>                                                                          =
                   V
>
> [root@quaco ~]# perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augm=
ented_raw_syscalls.o,$(echo `grep path /sys/kernel/tracing/events/syscalls/=
sys_enter_*/format | cut -d'/' -f7 | sed s/sys_enter_//g | uniq` | sed 's/ =
/,/g')
>      0.000 :763846/763846 unlink(pathname: "_Gf6C.01MriB.quaco")  =3D 0
>      7.508 :763846/763846 unlink(pathname: "msgid.lock")          =3D 0
>      8.522 :763846/763846 unlink(pathname: "lkml/_Gf6C,01MriB.quaco") =3D=
 0
>     16.243 :763846/763846 unlink(pathname: "lkml/tmp/1655491956.763846_2.=
quaco") =3D 0
>     16.313 :763846/763846 unlink(pathname: "lkml/.lock")          =3D 0
>    822.707 fetchmail/763848 unlink(pathname: "_If6C.11MriB.quaco")  =3D 0
>    830.511 fetchmail/763848 unlink(pathname: "msgid.lock")          =3D 0
>    831.800 fetchmail/763848 unlink(pathname: "lkml/_If6C,11MriB.quaco") =
=3D 0
>    835.622 BgIOThr~ol #11/747565 mkdir(pathname: "/home/acme/.mozilla/fir=
efox/7sbuc7kl.default-1636637603014/sessionstore-backups", mode: IRUGO|IXUG=
O|IWUSR) =3D -1 EEXIST (File exists)
>    838.273 fetchmail/763848 unlink(pathname: "lkml/tmp/1655491957.763848_=
2.quaco") =3D 0
>    838.292 fetchmail/763848 unlink(pathname: "lkml/.lock")          =3D 0
>    907.718 iceccd/1162 statfs(pathname: "/var/cache/icecream", buf: 0x7ff=
eda7437b0) =3D 0
>   1648.442 procmail/763850 unlink(pathname: "_Kf6C.11MriB.quaco")  =3D 0
>   1656.517 procmail/763850 unlink(pathname: "msgid.lock")          =3D 0
>   1658.118 procmail/763850 unlink(pathname: "lkml/_Kf6C,11MriB.quaco") =
=3D 0
>   1665.168 procmail/763850 unlink(pathname: "lkml/tmp/1655491957.763850_2=
.quaco") =3D 0
>   1665.237 procmail/763850 unlink(pathname: "lkml/.lock")          =3D 0
> ^C[root@quaco ~]#
>
> > doing it via BPF as a GSoC project [1]. Unfortunately there were no
>
> The GSoC project should've been about converting this primeval way of
> doing eBPF to something more modern, like BPF skels, as was done by Song
> Liu and Namhyung Kim for bpf counters, OFF-cpu profiling, etc, and is
> now being consdered for further work on 'perf kwork' :-)
>
> Sorry for not having catch that GSoC work item :-\
>
> Back to Kyle's question: yeah, building augmented_raw_syscalls.o as parf
> of building tools/perf/ and then installing it somewhere in the system
> to then automagically use it is something I should've done already :-\
>
> One other way to have it to be used automagically is by doing this:
>
> [root@quaco ~]# perf config trace.add_events=3D/home/acme/git/perf/tools/=
perf/examples/bpf/augmented_raw_syscalls.o
> [root@quaco ~]# perf config
> llvm.dump-obj=3Dtrue
> llvm.clang-opt=3D-g
> trace.show_zeros=3Dyes
> trace.show_duration=3Dno
> trace.no_inherit=3Dyes
> trace.args_alignment=3D40
> trace.add_events=3D/home/acme/git/perf/tools/perf/examples/bpf/augmented_=
raw_syscalls.o
> annotate.hide_src_code=3Dfalse
> [root@quaco ~]#
>
> And then lets have a statfs snooper:
>
> [root@quaco ~]# perf trace -e statfs
>      0.000 iceccd/1162 statfs(pathname: "/var/cache/icecream", buf: 0x7ff=
eda7437b0) =3D 0
>   3006.886 iceccd/1162 statfs(pathname: "/var/cache/icecream", buf: 0x7ff=
eda7437b0) =3D 0
>   3402.747 IndexedDB #286/764290 statfs(pathname: "/home/acme/.mozilla/fi=
refox/7sbuc7kl.default-1636637603014/storage/default/https+++web.whatsapp.c=
om/idb/3166453069wcaw.sqlite", buf: 0x7f9307ffe250) =3D 0
>   6022.494 iceccd/1162 statfs(pathname: "/var/cache/icecream", buf: 0x7ff=
eda7437b0) =3D 0
>   9038.105 iceccd/1162 statfs(pathname: "/var/cache/icecream", buf: 0x7ff=
eda7437b0) =3D 0
>  11466.825 IndexedDB #286/764812 statfs(pathname: "/home/acme/.mozilla/fi=
refox/7sbuc7kl.default-1636637603014/storage/default/https+++twitter.com/id=
b/1046228012scyn.sqlite", buf: 0x7f930e5d2250) =3D 0
>  12053.639 iceccd/1162 statfs(pathname: "/var/cache/icecream", buf: 0x7ff=
eda7437b0) =3D 0
>  12750.962 pkla-check-aut/765085 statfs(pathname: "", buf: 0x7ffee1cabfc0=
) =3D 0
>  12750.982 pkla-check-aut/765085 statfs(pathname: "/sys/fs/selinux", buf:=
 0x7ffee1cabeb0) =3D 0
>  12751.601 pkla-check-aut/765085 statfs(pathname: "/", buf: 0x7ffee1cab8f=
0) =3D 0
>  12932.910 pkla-check-aut/765090 statfs(pathname: "", buf: 0x7ffcc21cb000=
) =3D 0
>  12932.926 pkla-check-aut/765090 statfs(pathname: "/sys/fs/selinux", buf:=
 0x7ffcc21caef0) =3D 0
>  12933.367 polkitd/765090 statfs(pathname: "/", buf: 0x7ffcc21ca930) =3D =
0
>  18294.104 Cache2 I/O/3789 statfs(pathname: "/home/acme/.cache/mozilla/fi=
refox/7sbuc7kl.default-1636637603014/cache2", buf: 0x7f9330924ab0) =3D 0
>  18294.995 Cache2 I/O/3789 statfs(pathname: "/home/acme/.cache/mozilla/fi=
refox/7sbuc7kl.default-1636637603014/cache2", buf: 0x7f9330924a60) =3D 0
>  18295.870 Cache2 I/O/3789 statfs(pathname: "/home/acme/.cache/mozilla/fi=
refox/7sbuc7kl.default-1636637603014/cache2", buf: 0x7f9330924ab0) =3D 0
>  18296.661 Cache2 I/O/3789 statfs(pathname: "/home/acme/.cache/mozilla/fi=
refox/7sbuc7kl.default-1636637603014/cache2", buf: 0x7f9330924a60) =3D 0
>  18320.402 QuotaManager I/3837 statfs(pathname: "/home/acme/.mozilla/fire=
fox/7sbuc7kl.default-1636637603014/storage/default/https+++mail.google.com/=
idb/953658429glmaaviyle-ks-w.sqlite", buf: 0x7f9313ffb190) =3D 0
> ^C[root@quaco ~]#
>
> Looking at https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/tree/tools/perf/examples/bpf/augmented_raw_syscalls.c
>
> One can see that it also works with multiple pathanmes, for things like
> rename*:
>
> [root@quaco ~]# perf trace -e rename*
>      0.000 BgIOThr~ol #12/765110 rename(oldname: "/home/acme/.mozilla/fir=
efox/7sbuc7kl.default-1636637603014/sessionstore-backups/recovery.jsonlz4",=
 newname: "/home/acme/.mozilla/firefox/7sbuc7kl.default-1636637603014/sessi=
onstore-backups/recovery.baklz4") =3D 0
>      4.033 BgIOThr~ol #12/765110 rename(oldname: "/home/acme/.mozilla/fir=
efox/7sbuc7kl.default-1636637603014/sessionstore-backups/recovery.jsonlz4.t=
mp", newname: "/home/acme/.mozilla/firefox/7sbuc7kl.default-1636637603014/s=
essionstore-backups/recovery.jsonlz4") =3D 0
> ^C
>
> And a struct:
>
> [root@quaco ~]# perf trace -e sendto*,connect*
>      0.000 DNS Res~ver #3/566719 sendto(fd: 102, buff: 0x7f930e944000, le=
n: 20, flags: NONE, addr: { .family: NETLINK }, addr_len: 0xc) =3D 20
>      0.744 DNS Res~ver #3/566719 connect(fd: 102, uservaddr: { .family: L=
OCAL, path: /run/systemd/resolve/io.systemd.Resolve }, addrlen: 42) =3D 0
>      0.984 DNS Res~ver #3/566719 sendto(fd: 102, buff: 0x7f92aa01c580, le=
n: 98, flags: DONTWAIT|NOSIGNAL, addr: { .family: UNSPEC }, addr_len: NULL)=
 =3D 98
>      2.141 systemd-resolv/949 connect(fd: 23, uservaddr: { .family: INET,=
 port: 53, addr: 127.0.0.1 }, addrlen: 16) =3D 0
>      2.443 systemd-resolv/949 connect(fd: 24, uservaddr: { .family: INET,=
 port: 53, addr: 127.0.0.1 }, addrlen: 16) =3D 0
>      2.767 systemd-resolv/949 sendto(fd: 21, buff: 0x55ada5d33580, len: 1=
77, flags: DONTWAIT|NOSIGNAL, addr: { .family: UNSPEC }, addr_len: NULL) =
=3D 177
>      3.070 DNS Res~ver #3/566719 connect(fd: 102, uservaddr: { .family: I=
NET6, port: 0, addr: 2800:3f0:4004:80d::200e }, addrlen: 28) =3D -1 ENETUNR=
EACH (Network is unreachable)
>      3.105 DNS Res~ver #3/566719 connect(fd: 102, uservaddr: { .family: U=
NSPEC }, addrlen: 16) =3D 0
>      3.112 DNS Res~ver #3/566719 connect(fd: 102, uservaddr: { .family: I=
NET, port: 0, addr: 142.250.218.46 }, addrlen: 16) =3D 0
>      5.225 DNS Res~ver #2/555179 sendto(fd: 102, buff: 0x7f932a0bc000, le=
n: 20, flags: NONE, addr: { .family: NETLINK }, addr_len: 0xc) =3D 20
>      5.392 DNS Res~ver #2/555179 connect(fd: 102, uservaddr: { .family: L=
OCAL, path: /run/systemd/resolve/io.systemd.Resolve }, addrlen: 42) =3D 0
>      5.444 DNS Res~ver #2/555179 sendto(fd: 102, buff: 0x7f92aa01c200, le=
n: 98, flags: DONTWAIT|NOSIGNAL, addr: { .family: UNSPEC }, addr_len: NULL)=
 =3D 98
>      5.772 systemd-resolv/949 connect(fd: 23, uservaddr: { .family: INET,=
 port: 53, addr: 127.0.0.1 }, addrlen: 16) =3D 0
>      5.921 Socket Thread/3774 sendto(fd: 178, buff: 0x7f92cab82000, len: =
385, flags: NONE, addr: { .family: UNSPEC }, addr_len: NULL) =3D 385
>      5.978 Socket Thread/3774 sendto(fd: 178, buff: 0x7f92cab82000, len: =
185, flags: NONE, addr: { .family: UNSPEC }, addr_len: NULL) =3D 185
>      5.906 systemd-resolv/949 connect(fd: 24, uservaddr: { .family: INET,=
 port: 53, addr: 127.0.0.1 }, addrlen: 16) =3D 0
>      6.113 Socket Thread/3774 sendto(fd: 178, buff: 0x7f92cab82000, len: =
3604, flags: NONE, addr: { .family: UNSPEC }, addr_len: NULL) =3D 3604
>      6.261 systemd-resolv/949 sendto(fd: 21, buff: 0x55ada5d33580, len: 1=
77, flags: DONTWAIT|NOSIGNAL, addr: { .family: UNSPEC }, addr_len: NULL) =
=3D 177
>      6.416 DNS Res~ver #2/555179 connect(fd: 102, uservaddr: { .family: I=
NET6, port: 0, addr: 2800:3f0:4004:80d::200e }, addrlen: 28) =3D -1 ENETUNR=
EACH (Network is unreachable)
>      6.436 DNS Res~ver #2/555179 connect(fd: 102, uservaddr: { .family: U=
NSPEC }, addrlen: 16) =3D 0
>      6.444 DNS Res~ver #2/555179 connect(fd: 102, uservaddr: { .family: I=
NET, port: 0, addr: 142.250.218.46 }, addrlen: 16) =3D 0
>    147.212 Socket Thread/3774 sendto(fd: 178, buff: 0x7f92cab82000, len: =
39, flags: NONE, addr: { .family: UNSPEC }, addr_len: NULL) =3D 39
>    295.713 pool-gsd-smart/2859 sendto(fd: 13, buff: 0x7f2f8926c860, len: =
8, flags: NOSIGNAL, addr: { .family: UNSPEC }, addr_len: NULL) =3D 8
>    295.941 pcscd/2594 sendto(fd: 15, buff: 0x55c9634a7480, len: 8832, fla=
gs: NOSIGNAL, addr: { .family: UNSPEC }, addr_len: NULL) =3D 8832
>    297.204 pool-gsd-smart/2859 sendto(fd: 13, buff: 0x7f2f8926c798, len: =
8, flags: NOSIGNAL, addr: { .family: UNSPEC }, addr_len: NULL) =3D 8
>    297.345 pcscd/2594 sendto(fd: 15, buff: 0x7ffa857d9b30, len: 8, flags:=
 NOSIGNAL, addr: { .family: UNSPEC }, addr_len: NULL) =3D 8
>    297.526 pool-gsd-smart/2859 sendto(fd: 13, buff: 0x7f2f8926c860, len: =
8, flags: NOSIGNAL, addr: { .family: UNSPEC }, addr_len: NULL) =3D 8
>    297.636 pcscd/2594 sendto(fd: 15, buff: 0x55c9634a7480, len: 8832, fla=
gs: NOSIGNAL, addr: { .family: UNSPEC }, addr_len: NULL) =3D 8832
>    297.818 pool-gsd-smart/2859 sendto(fd: 13, buff: 0x7f2f8926c798, len: =
8, flags: NOSIGNAL, addr: { .family: UNSPEC }, addr_len: NULL) =3D 8
>    298.013 pcscd/2594 sendto(fd: 15, buff: 0x7ffa857d9b30, len: 8, flags:=
 NOSIGNAL, addr: { .family: UNSPEC }, addr_len: NULL) =3D 8
>    371.885 procmail/765765 sendto(fd: 5, buff: 0x7ffd3e5f3ad0, len: 20, f=
lags: NONE, addr: { .family: NETLINK }, addr_len: 0xc) =3D 20
>    588.186 procmail/765765 sendto(fd: 6, buff: 0x55c8e5768ab0, len: 61, f=
lags: NONE, addr: { .family: INET, port: 512, addr: 127.0.0.1 }, addr_len: =
0x10) =3D 61
>    840.937 Socket Thread/3774 sendto(fd: 316, buff: 0x7f92c8d0b588, len: =
34, flags: NONE, addr: { .family: INET, port: 443, addr: 142.250.79.234 }, =
addr_len: 0x10) =3D 34
> ^C[root@quaco ~]#
>
> There is logic to look for other syscalls not directly handled in
> augmented_raw_syscalls.c that have similar function signatures, i.e.
> what is explicitely handled is used as templates.
>
> See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dad4153f964ebb756617e1586ba372156db0efeed
>
> All this do not use BTF, which is an utter shame, and if you ask me, a
> low hanging fruit for people wanting to help :-)
>
> As a teaser, please try:
>
> # wget http://vger.kernel.org/~acme/perf/augmented_raw_syscalls.o
> # perf config trace.add_events=3D/home/acme/git/perf/tools/perf/examples/=
bpf/augmented_raw_syscalls.o
> # perf trace -e open*
>
> To see if it works :-)
>
> Doing this with BPF skels, sleepable syscall BPF programs, BTF, etc is
> on my TODO list for a long time :-\

:-) Mountain of a reply, I'll need to read it in more detail but
thanks for the detail. Could we get perf_event_open augmentation as
that's what I'm usually after debugging :-)

Thanks,
Ian

> - Arnaldo
>
> > takers this year.
> >
> > Thanks,
> > Ian
> >
> > [1] https://wiki.linuxfoundation.org/gsoc/2022-gsoc-perf
