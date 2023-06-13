Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1ABC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 02:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbjFMCeK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 22:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjFMCeK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 22:34:10 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5A6AA
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 19:34:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b3b9413baaso58695ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 19:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686623648; x=1689215648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXqfWu5PKRoEVNpvumjFSb5/+qzDSIipTDolF4VOWfg=;
        b=Q3WlXHVB9NPnLcJz0Ofrpw+T2ewlZb2jjB2Uz7ntIGlw0zU6oQkqWxlwYbQljB9D41
         uOvHJSsGJ4G1bMC1nJpLnC1Ji9pOu/Z8Bmr+juPni8vzvRE2FYMmw/HAV8nvL8du06EG
         nYOUxnuRfuqEr6NnbRhnX/cMGMMQAzSt7wmJu0WytOFIOLafEgFV9MRL40PGLg5UcTL5
         auX/vRm6k5F2cZAnVryKMUNDk113kAwJjxB9Rh4BmjbmVOBE0zGO/0xlEe5qyMK+VtQb
         8mvW3zfpvALCe8x7jQofU6fuChR7C5rBCjwDJZzboYY17c/BVlhxqUkxE9gwnQYGILqO
         OP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686623648; x=1689215648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXqfWu5PKRoEVNpvumjFSb5/+qzDSIipTDolF4VOWfg=;
        b=R41ID8xTSKnUXUBzFko/baR3wGYw56sVEGEhnOr/RuQka9+13TWhKOUnDRRr4KB6dY
         Erl82v1KDPSyGIu5bkudgKJxj4t9vkitIRf9L0bz4DHWjjEySBC3yd2ohuOPZaNt+y5s
         nKRvasitpDWAeBJhZWpYaTq47rSRe30lXewg1xyUsza5DQAeoKinVdcZ04uO/HSEUPg9
         5xtViSkDZLSodJmbOl3OkIY3vaETpAFt+DqMqD7It32RDkgTU8K9vFRcPTNKehewf08e
         7RCIco5xicb8hA43/fcdwFKnLoHhaW2v1ZI7tdUT4wYZlDMvYLnF15te7bSeEJ0rT2c7
         LdXA==
X-Gm-Message-State: AC+VfDxnfLlTO0cF79rCOmJUuStN4hs+FHzqXlJ0oMi6YyXgNdlJ06l/
        sD3zHHer4cOoB/+Io5uMawAOWaupQgEO4yQqlW3N1Q==
X-Google-Smtp-Source: ACHHUZ4GizvDmUxuiILg7h1HSW+bwK4XoOZ9yQAa88PAaqYEYLp5LMrocsXnw05gipBt4Jm8I+oqyvIpvjm4To5YtiI=
X-Received: by 2002:a17:902:f646:b0:1b3:bf79:605f with SMTP id
 m6-20020a170902f64600b001b3bf79605fmr25138plg.24.1686623648082; Mon, 12 Jun
 2023 19:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230609033128.ujodex56vkha2ifr@M910t> <CAP-5=fVWhp_cMpgwTRiO+bC7tKKGvKsavRVVDW-k9qYB7ZoXWg@mail.gmail.com>
 <CAP-5=fWRpZSYcuuiSKGL4cS+SDBaSA6GBXJuw-gQAir+4EsagA@mail.gmail.com>
 <20230612021405.kcaccxchmb5juep4@M910t> <CAP-5=fUySkKsAzx-O4-iLsqjhqd53vkx6Wmw+rj5UUrOB88h6A@mail.gmail.com>
 <20230612131042.vkwoaucccwdrhl5a@M910t> <20230612131750.yisfy7zan64beg7y@M910t>
 <CAP-5=fWdvMVOiZDhqiz1R9hucz+6+ho_L3jBixqP3YLcJD7Lew@mail.gmail.com>
 <20230613022017.wmukzivie4q3gmcp@M910t> <CAP-5=fUcO1cgBhfYx-4RMBJC=fqMXjaD7jYw6SYvnZ-e+vVN-A@mail.gmail.com>
 <20230613023155.ewu4ipi3ldd7hevj@M910t>
In-Reply-To: <20230613023155.ewu4ipi3ldd7hevj@M910t>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 12 Jun 2023 19:33:56 -0700
Message-ID: <CAP-5=fXOPN3M+hRs51a91NF6PZHmAPpnAU=V6zw20Rk3xy4K-Q@mail.gmail.com>
Subject: Re: [Issue] perf report gets stuck at addr2line
To:     Changbin Du <changbin.du@huawei.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        hw.huiwang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 12, 2023 at 7:32=E2=80=AFPM Changbin Du <changbin.du@huawei.com=
> wrote:
>
> On Mon, Jun 12, 2023 at 07:25:41PM -0700, Ian Rogers wrote:
> > On Mon, Jun 12, 2023 at 7:20=E2=80=AFPM Changbin Du <changbin.du@huawei=
.com> wrote:
> > >
> > > On Mon, Jun 12, 2023 at 08:55:14AM -0700, Ian Rogers wrote:
> > > > On Mon, Jun 12, 2023 at 6:18=E2=80=AFAM Changbin Du <changbin.du@hu=
awei.com> wrote:
> > > >
> > > > Thanks Changbin, this should have hit the 0x0...0 sentinel match:
> > > >
> > > > https://lore.kernel.org/lkml/20230609235419.204624-2-irogers@google=
.com/
> > > > + } else {
> > > > + int zero_count =3D 0, non_zero_count =3D 0;
> > > > +
> > > > + /* The address should always start 0x. */
> > > > + if (line_len < 2 || line[0] !=3D '0' || line[1] !=3D 'x')
> > > > + goto error;
> > > > +
> > > > + for (size_t i =3D 2; i < line_len; i++) {
> > > > + if (line[i] =3D=3D '0')
> > > > + zero_count++;
> > > > + else
> > > > + non_zero_count++;
> > > > + }
> > > > + if (!non_zero_count) {
> > > > + int ch;
> > > > +
> > > > + if (!zero_count) {
> > > > + /* Line was erroneous just '0x'. */
> > > > + goto error;
> > > > + }
> > > > + /*
> > > > + * Line was 0x0..0, the sentinel for binutils. Remove
> > > > + * the function and filename lines.
> > > > + */
> > > > + zfree(&line);
> > > > + do {
> > > > + ch =3D io__get_char(io);
> > > > + } while (ch > 0 && ch !=3D '\n');
> > > > + do {
> > > > + ch =3D io__get_char(io);
> > > > + } while (ch > 0 && ch !=3D '\n');
> > > > + return 0;
> > > > + }
> > > >   }
> > > >
> > > > That doesn't use io__getline - so we've not matched the 0x0...0 cas=
e
> > > > to terminate the records. Could you add some logging/debug?
> > > >
> > > I printed every charactor got by io__get_char(), based on previous de=
bug change.
> > > Please see logs below.
> > >
> > > # To display the perf.data header info, please use --header/--header-=
only options.
> > > #
> > > addr2line: /home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa9=
8d6fa3776974b54/elf, addr ffffffff81e000aa
> > > subprocess: addr2line -e /home/changbin/.debug/.build-id/5e/2fa721660=
d663f38b6e1aa98d6fa3776974b54/elf -a -i -f
> > > io__get_char: '0'
> > > io__get_char: 'x'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '
> > > '
> > > io__get_char: '_'
> > > io__get_char: '_'
> > > io__get_char: 'p'
> > > io__get_char: 'e'
> > > io__get_char: 'r'
> > > io__get_char: '_'
> > > io__get_char: 'c'
> > > io__get_char: 'p'
> > > io__get_char: 'u'
> > > io__get_char: '_'
> > > io__get_char: 's'
> > > io__get_char: 't'
> > > io__get_char: 'a'
> > > io__get_char: 'r'
> > > io__get_char: 't'
> > > io__get_char: '
> > > '
> > > io__get_char: '?'
> > > io__get_char: '?'
> > > io__get_char: ':'
> > > io__get_char: '?'
> > > io__get_char: '
> > > '
> > > read_addr2line_record
> > > io__getline: start
> > > io__get_char: '0'
> > > io__get_char: 'x'
> > > io__get_char: 'f'
> > > io__get_char: 'f'
> > > io__get_char: 'f'
> > > io__get_char: 'f'
> > > io__get_char: 'f'
> > > io__get_char: 'f'
> > > io__get_char: 'f'
> > > io__get_char: 'f'
> > > io__get_char: '8'
> > > io__get_char: '1'
> > > io__get_char: 'e'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: 'a'
> > > io__get_char: 'a'
> > > io__get_char: '
> > > '
> > > io__getline: 0xffffffff81e000aa
> > >
> > > io__getline: start
> > > io__get_char: 'e'
> > > io__get_char: 'n'
> > > io__get_char: 't'
> > > io__get_char: 'r'
> > > io__get_char: 'y'
> > > io__get_char: '_'
> > > io__get_char: 'S'
> > > io__get_char: 'Y'
> > > io__get_char: 'S'
> > > io__get_char: 'C'
> > > io__get_char: 'A'
> > > io__get_char: 'L'
> > > io__get_char: 'L'
> > > io__get_char: '_'
> > > io__get_char: '6'
> > > io__get_char: '4'
> > > io__get_char: '_'
> > > io__get_char: 'a'
> > > io__get_char: 'f'
> > > io__get_char: 't'
> > > io__get_char: 'e'
> > > io__get_char: 'r'
> > > io__get_char: '_'
> > > io__get_char: 'h'
> > > io__get_char: 'w'
> > > io__get_char: 'f'
> > > io__get_char: 'r'
> > > io__get_char: 'a'
> > > io__get_char: 'm'
> > > io__get_char: 'e'
> > > io__get_char: '
> > > '
> > > io__getline: entry_SYSCALL_64_after_hwframe
> > >
> > > io__getline: start
> > > io__get_char: '?'
> > > io__get_char: '?'
> > > io__get_char: ':'
> > > io__get_char: '?'
> > > io__get_char: '
> > > '
> > > io__getline: ??:?
> > >
> > > read_addr2line_record
> > > io__getline: start
> > > io__get_char: '0'
> > > io__get_char: 'x'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '0'
> > > io__get_char: '
> > > '
> > > io__getline: 0x0000000000000000
> > >
> > > io__getline: start
> > > io__get_char: '_'
> > > io__get_char: '_'
> > > io__get_char: 'p'
> > > io__get_char: 'e'
> > > io__get_char: 'r'
> > > io__get_char: '_'
> > > io__get_char: 'c'
> > > io__get_char: 'p'
> > > io__get_char: 'u'
> > > io__get_char: '_'
> > > io__get_char: 's'
> > > io__get_char: 't'
> > > io__get_char: 'a'
> > > io__get_char: 'r'
> > > io__get_char: 't'
> > > io__get_char: '
> > > '
> > > io__getline: __per_cpu_start
> > >
> > > io__getline: start
> > > io__get_char: '?'
> > > io__get_char: '?'
> > > io__get_char: ':'
> > > io__get_char: '?'
> > > io__get_char: '
> > > '
> > > io__getline: ??:?
> > >
> > > read_addr2line_record
> > > io__getline: start
> > > [stuck]
> >
> >
> > Cool. Looks like the terminating '\n' is the issue. It is specified to
> > be part of getline. Can you tweak:
> >
> > + if (line[i] =3D=3D '0')
> > + zero_count++;
> > + else
> > + non_zero_count++;
> >
> > to be:
> >
> > + if (line[i] =3D=3D '0')
> > + zero_count++;
> > + else if (line[i] !=3D '\n')
> > + non_zero_count++;
> >
> Wonderful, this works. The issue is gone with this change. :)

Cool. I'll send out a new patch set. Thanks,
Ian

> > Thanks,
> > Ian
> >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > > > Thanks,
> > > > > > > Ian
> > > > > > >
> > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Ian
> > > > > > > > > >
> > > > > > > > > > > --
> > > > > > > > > > > Cheers,
> > > > > > > > > > > Changbin Du
> > > > > > > >
> > > > > > > > --
> > > > > > > > Cheers,
> > > > > > > > Changbin Du
> > > > > >
> > > > > > --
> > > > > > Cheers,
> > > > > > Changbin Du
> > > > >
> > > > > --
> > > > > Cheers,
> > > > > Changbin Du
> > >
> > > --
> > > Cheers,
> > > Changbin Du
>
> --
> Cheers,
> Changbin Du
