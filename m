Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E48C77B7A
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Apr 2023 21:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjDSVZJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 Apr 2023 17:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjDSVYy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 Apr 2023 17:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A019546B8
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681939388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaQHymcXw0G5greCJkKrqRv1UnH5au1Y5rlfhOXALhs=;
        b=XvvC2x70ogoFRJMfbr+qqfrlSJVM3k2pafiEfEzZcQB1fKcynYGo+PLs2ZXiMoUpqx1UOP
        /EYioM+HfkjBTXomTvyA8J7igP+rJYypKWh5HcJqU5UpJPEsCSK1giwZlmW/xTi6Wmyl9B
        JcFDd7GHP08fIaGbWj9Q1lIYaIq9xH4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-oRD-n4eFOoaDNdjIFMnHrQ-1; Wed, 19 Apr 2023 17:23:07 -0400
X-MC-Unique: oRD-n4eFOoaDNdjIFMnHrQ-1
Received: by mail-ed1-f72.google.com with SMTP id x5-20020a50d605000000b005066c2aa22aso524469edi.17
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Apr 2023 14:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939386; x=1684531386;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaQHymcXw0G5greCJkKrqRv1UnH5au1Y5rlfhOXALhs=;
        b=CScR+KlOQhslkgL76M5xhsm8UlPS/djrNe6Q3nHHYUJnbZ11Y/JFtuUEwhLtQwBOW3
         e56n/1yiB6bPwPo09pEsscHNPtn6+Vi7rU38MUjJvqVOJfP7AV9H5dqBxq9EVRLoJt3k
         f9WqZWCCLkLqQyjnTAM7HS7K5yG4o0mDCJheMg4tUVnWaQgS6vtvuwWhsx6xguW9YZko
         bhqwiu09Q0WsrXbycjT4KB0kLuEd/ZzLkEUt48LwWj7zbGkLlfoHp/BWvFKAkTUgD+As
         EnfflHo+Ay3Vv4cWhNJFFPw/QXvIKa478XNSgn1huHhw34tGhLLpSsfQSad20beaGdLy
         coBQ==
X-Gm-Message-State: AAQBX9c1azoSa8XCcq/USMaHhnxq8sYISP8+0BiolvlkuMFJFTNDXLpg
        O8+fAZ9YR8JAegnO2A5Fjds/6s7UPi3q0CC+oAsybuMHpKvaCtRxHE19F4gUDoLyTrCt24mZjPe
        UzEY7A6+AwaKA7iTWPZRVsOIC9XuZfQ==
X-Received: by 2002:a17:907:7205:b0:953:5eb4:fe45 with SMTP id dr5-20020a170907720500b009535eb4fe45mr3248935ejc.23.1681939385015;
        Wed, 19 Apr 2023 14:23:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350YOTv3sBWq+Vepcji4L2B0tLPY3ZwdutkdiMpScSp2VrgN2RjKbZx8hngYcAD1+Azjb28NGZA==
X-Received: by 2002:a17:907:7205:b0:953:5eb4:fe45 with SMTP id dr5-20020a170907720500b009535eb4fe45mr3248901ejc.23.1681939383961;
        Wed, 19 Apr 2023 14:23:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id sa39-20020a1709076d2700b0094f410225c7sm5854659ejc.169.2023.04.19.14.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:23:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 843C0AA8C2B; Wed, 19 Apr 2023 23:23:02 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Mahe Tardy <mahe.tardy@gmail.com>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
In-Reply-To: <CAEf4BzZfGewUgYsNNqCgES5Y5-pqbSRDbhtKiuSC7=G_83tyig@mail.gmail.com>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz>
 <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
 <20230414161520.GJ63923@kunlun.suse.cz>
 <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
 <20230418112454.GA15906@kitsune.suse.cz>
 <CAEf4BzZf50fX7T9k47u+9YQrMbSLxLeA1qWwrdWToCZkMhynjg@mail.gmail.com>
 <20230418174132.GE15906@kitsune.suse.cz> <ZD/3Ll7UPucyOYkk@syu-laptop.lan>
 <CAEf4BzZfGewUgYsNNqCgES5Y5-pqbSRDbhtKiuSC7=G_83tyig@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 19 Apr 2023 23:23:02 +0200
Message-ID: <87zg73tvm1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Apr 19, 2023 at 7:14=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.c=
om> wrote:
>>
>> On Tue, Apr 18, 2023 at 07:41:32PM +0200, Michal Such=C3=A1nek wrote:
>> > On Tue, Apr 18, 2023 at 09:38:20AM -0700, Andrii Nakryiko wrote:
>> > > On Tue, Apr 18, 2023 at 4:24=E2=80=AFAM Michal Such=C3=A1nek <msucha=
nek@suse.de> wrote:
>> > > >
>> > > > On Mon, Apr 17, 2023 at 05:20:03PM -0700, Andrii Nakryiko wrote:
>> > > > > On Fri, Apr 14, 2023 at 9:15=E2=80=AFAM Michal Such=C3=A1nek <ms=
uchanek@suse.de> wrote:
>> > > > > > On Fri, Apr 14, 2023 at 01:30:02PM +0100, Quentin Monnet wrote:
>> > > > > > > 2023-04-14 11:50 UTC+0200 ~ Michal Such=C3=A1nek <msuchanek@=
suse.de>
>> > > > > > > > Hello,
>> > > > > > > >
>> > > > > > > > On Fri, Apr 14, 2023 at 01:35:20AM +0100, Quentin Monnet w=
rote:
>> > > > > > > >> Hi Shung-Hsi,
>> > > > > > > >>
>> > > > > > > >> On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@=
suse.com> wrote:
>> > > > > > > >>>
>> > > > > > > >>> Hi,
>> > > > > > > >>>
>> > > > > > > >>> I'm considering switch to bpftool's mirror on GitHub for=
 packaging (instead
>> > > > > > > >>> of using the source found in kernel), but realize that i=
t should goes
>> > > > > > > >>> hand-in-hand with how libbpf is packaged, which eventual=
ly leads these
>> > > > > > > >>> questions:
>> > > > > > > >>>
>> > > > > > > >>>   What is the suggested approach for packaging bpftool a=
nd libbpf?
>> > > > > > > >>>   Which source is preferred, GitHub or kernel?
>> > > > > > > >>
>> > > > > > > >> As you can see from the previous discussions, the suggest=
ed approach
>> > > > > > > >> would be to package from the GitHub mirror, with libbpf a=
nd bpftool in
>> > > > > > > >> sync.
>> > > > > > > >>
>> > > > > > > >> My main argument for the mirror is that it keeps things s=
impler, and
>> > > > > > > >> there's no need to deal with the rest of the kernel sourc=
es for these
>> > > > > > > >> packages. Download from the mirrors, build, ship. But the=
n I have
>> > > > > > > >> limited experience at packaging for distros, and I can un=
derstand
>> > > > > > > >> Toke's point of view, too. So ultimately, the call is you=
rs.
>> > > > > > > >
>> > > > > > > > Things get only ever more complex when submodules are invo=
lved.
>> > > > > > >
>> > > > > > > I understand the generic pain points from your other email. =
But could
>> > > > > > > you be more specific for the case of bpftool? It's not like =
we're
>> > > > > > > shipping all lib dependencies as submodules. Sync-ups are sp=
ecifically
>> > > > > > > aligned to the same commit used to sync the libbpf mirror, s=
o that it's
>> > > > > > > pretty much as if we had the right version of the library sh=
ipped in the
>> > > > > > > repository - only, it's one --recurse-submodules away.
>> > > > > >
>> > > > > > It's so in every project that uses submodules. Except git does=
 not
>> > > > > > recurse into submodules by default, you have to fix it up by h=
and.
>> > > > > > Forges don't support submodules so you will not get the submod=
ule when
>> > > > > > downloading the project archive, and won't see it the the proj=
ect tree.
>> > > > >
>> > > > > git submodule update --init --recursive didn't work?
>> > > >
>> > > > That's one part of the manual fixup.
>> > > >
>> > > > The other part is after each git operation that could possibly cau=
se the
>> > > > submodules to go out of sync, basically any operation that changes=
 the
>> > > > checked-out commit.
>> > > >
>> > > > Of course, you can make some shell aliases that append whatever su=
bmodule
>> > > > chicanery to whatever git command you might issue, and tell everyo=
ne
>> > > > else to do that, and then it will work in that one shell, and not =
in any
>> > > > other shell nor any tool that invokes git directly.
>> > >
>> > > Are we discussing a *standard* Git submodule feature and argue that
>> > > because it might be cumbersome or unfamiliar to some engineers that
>> > > projects should avoid using Git submodules?
>> >
>> > As far as I am aware they are unfamiliar to *most* engineers, and for
>> > good reasons.
>> >
>> > > For one, I don't have any special aliases for dealing with Git
>> > > submodules and it works fine. If I jump between branches or tags whi=
ch
>> > > update Git submodule reference, I do above `git submodule update
>> > > --init --recursive` explicitly if I see that Git status shows
>> > > out-of-sync Git submodule state. If I want to update a Git submodule,
>> > > I update the submodule's Git repo, and then git add it in the repo
>> > > that uses this submodule. I haven't run into any other issues with
>> > > this.
>> >
>> > You know, git could just handle submodules automagically. As you say,
>> > it's not rocket science. For historical reasons it does not.
>> >
>> > With that working with submodules is cumbersome, and it's additional
>> > thing that can break down that the engineer needs to be constantly awa=
re
>> > of increasing the mental overhead of working with such projects.
>> >
>> > It may not be much of a problem for people who work with such projects
>> > daily but not everyone does. Those who don't need to do the mental
>> > switch whenever submodules are encountered, and are prone to getting
>> > issues when they forget that they have to go that extra mile for this
>> > specific project.
>>
>> For me it's less about having to go through the extra loop. It's that
>> submodules would require git to be installed, network access, which all =
adds
>> extra moving parts compared to a tarball...
>>
>> > > > > > After previous experience with submodules I did not even try, =
I just
>> > > > > > patched the makefile to use system libbpf before attempting an=
ything
>> > > > > > else.
>> > > > >
>> > > > > Quentin mentioned that he's packaging (or will package) libbpf s=
ources
>> > > > > as part of bpftool release on Github. I've been this for other
>> > > > > libbpf-using tools as well, and it works pretty well (at least f=
or
>> > > > > Fedora and ArchLinux). E.g., srcs-full-* archives for veristat (=
[0])
>>
>> and having libbpf included in bpftool release means the complain above no
>> longer holds. Though I have yet test build the mirror version of libbpf =
and
>> bpftool like Michal has done.
>
> Great. This seems to work well for other tools that use libbpf through
> submodule (anakryiko/retsnoop and libbpf/veristat on Github)
>
>>
>> > > > > By switching up actual libbpf used to compile with bpftool, you =
are
>> > > > > potentially introducing subtle problems that your users will be =
quite
>> > > > > unhappy about, if they run into them. Let's work together to mak=
e it
>> > > > > easier for you to package bpftool properly. We can't switch bpft=
ool to
>> > > > > reliably use system-wide libbpf (either static or shared, doesn't
>> > > > > matter) because of dependency on internal functionality.
>> > > > >
>> > > > >
>> > > > >   [0] https://github.com/libbpf/veristat/releases/tag/v0.1
>> > > >
>> > > > So how many copies of libbpf do I need for having a CO-RE toolchai=
n?
>> > >
>> > > What do you mean by "CO-RE toolchain"? bpftool, veristat, retsnoop,
>> > > etc are tools. The fact they are using statically linked libbpf
>> > > through Git submodule is irrelevant to end users. You need one libbpf
>> > > in the system (for those who link dynamically against libbpf), the
>> > > rest are just tools.
>> > >
>> > > >
>> > > > Will different tools have different view of the kernel because the=
y each
>> > > > use different private copy of libbpf with different features?
>> > >
>> > > That's up to tools, not libbpf. You are over pivoting on libbpf here.
>> > > There is one view of the kernel, it depends on what features the
>> > > kernel supports. If the tool requires some specific functionality of
>> > > libbpf, it will update its Git submodule reference to get a version =
of
>> > > libbpf that provides that feature. That's the point, an
>> > > application/tool is in control of what kind of features it gets from
>> > > libbpf.
>>
>> Since libbpf has a stable API & ABI, is it theoretically possible for
>> bpftool, veristat, retsnoop, etc. all share the same version of libbpf?
>
> No, because libbpf is not just a set of APIs. Newer libbpf versions
> support more BPF-side features, more kernel features, etc, etc. Libbpf
> is not a typical user-space library, it is a BPF loader, and even if
> user-visible API doesn't change, libbpf's support for various BPF-side
> features is extended. Which is important for tools like bpftool,
> retsnoop, veristat which rely on loading and working with BPF object
> files.

The converse of this is also true: if your system is upgraded to a new
kernel version with new BPF features, the libbpf version should follow
it, and all applications linked against it will automatically take
advantage of any bugfixes regardless without having to wait for each
application to be updated.

Libbpf is really no different from any other library here, and I really
don't get why you keep insisting it's "special"...

>> What I'd like to do it build libbpf and bpftool out of bpftool GitHub
>> mirror's release tarball (w/ submodule included, which exists now for
>> snapshot). For the rest of the tool that does not depends on libbpf priv=
ate
>> function, have them dynamically link to the libbpf built from bpftool's
>> source, just like how libelf is dynamically linked.
>
> Please don't do it, let applications control which libbpf versions
> they are using. It's not just about user space APIs, I can't emphasize
> this enough. Don't think you know better than developers of respective
> applications, don't try to dictate how those applications should be
> organized and developed.

A well-behaved application will detect which features are available in
the system version of the libraries they use, and if something is
missing that it needs, either work around it or refuse to build. We do
this with libbpf in xdp-tools and the only issues we've had with it has
been the changing API in pre-1.0 libbpf...

> One good example is iproute2, which chose to link (or not) with libbpf
> dynamically. Now users periodically report various issues where their
> BPF object files are not loaded, and it often comes down to unexpected
> version of libbpf (or lack of libbpf support altogether) which which
> iproute2 was built/deployed. This is just putting a burden on iproute2
> users, and accidentally libbpf maintainers, for no good reason.

How would this have been any different if iproute2 was statically linked
against libbpf?

>> I'm not saying that those tools should not have libbpf as submodule; as
>> submodule do look useful. But for packaging I really would like to have =
the
>> option of choosing the exact version of libbpf being used.
>
> The exact version of libbpf used by bpftool, retsnoop, veristat, etc
> *is not relevant* to you as a packager. If you want happy users, use
> *exact* version of libbpf from submodule to build them, with which
> application was developed, tested, and advertised supported BPF
> features. There is no reuse to be done here, they all can be on
> different (and sometimes not yet released) libbpf version. For good
> reasons, which are outside of your control as a packager.

This is... just not how distributions work. As a user I trust my
distribution to provide me with a coherent system where critical system
libraries are maintained and receive timely updates. And I absolutely
trust the distribution more to do this over application developers who
just vendor in some version as a submodule and leave it there until they
need a new feature...

-Toke

