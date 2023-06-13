Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE4EC7EE43
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 02:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFMCZ4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 22:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjFMCZz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 22:25:55 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3461010F6
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 19:25:54 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f9d619103dso81461cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 19:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686623153; x=1689215153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6OObJxzwxIeNYDskZ/YkrmMqWUifk4ot9KO/UrvPQg=;
        b=2BY4BUlu/o7/BnLfIKHpLVZMl0LkEQacEs9Q54nsUCHtGy2Um2ofaJsqEMj1vWvDyI
         27IgFQovuyUqIU9I72uatYNstT0Hc/JKWUWcl/1uliKlbDM61rLMcy/axl8fIS3dKAz/
         +fc+6cuM2Tl9q0T0R4ynXQBzaVNG2xtH+FcbAljy5JcqWG/+hBwLF0MF/6n1FDMrlgIZ
         kUuLh2dfXuX++p4oiCVH71a7XGA1i/KtjTI/XjcXJfLLKlglOzfdvFyJ0HgtdbQ0lrEm
         2lCnhXIekEJYjnS5JOn4IxZftZVcplAW6m0hUXoYGZJZeolI/98YXDj8h3UlFfmkBcFP
         xx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686623153; x=1689215153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6OObJxzwxIeNYDskZ/YkrmMqWUifk4ot9KO/UrvPQg=;
        b=gpdQTCy5tGjaMMbbFlEuMtNDlsIM5CxYfQUbnZvQP3z1vjjGhRPGoUOxe8ut+NBYRy
         EkeFwPSTr3sLZByL6hliRdML3hxCfIZk4msajx3tJpUnsdwC4FlAmFqpB3LH1FtzL/+L
         MIYwoF1lpAb/v54bPXmhFD83NoEQNl+Bv4m6h6lB4X/pnpfEsASZihhfcbhQFmm4emDL
         E5bzsAyZuuUr+x7CXHlwVyHCfueKz0HDnpAMo4On5Y/sv+WnlPf3YMJH6Ly/kjCQ24E0
         BkVloGd+81S2wNwS5ZKWVeyRl1RhtmRXQJwlPFZSUyCHHPXKsjRdOQ7ra+gHDaG/VoQ4
         hTwA==
X-Gm-Message-State: AC+VfDyGoozGeyW/Rq0kwqMzEn6ldcgKWmzMLtY8s4iRDUi20+slCWex
        V1lrn8MH5qQ3aS7gD43TGeU5nxikgpi6LlNZOoT9yQ==
X-Google-Smtp-Source: ACHHUZ5jgkxY99/bwEcCSBYER2fNHpV+vRoHr3jfU2FhSqHQEvVRNxXv6SbRTq8r3IH7MJH6+UAitPefDrwXmL6mDGo=
X-Received: by 2002:ac8:5b11:0:b0:3de:1aaa:42f5 with SMTP id
 m17-20020ac85b11000000b003de1aaa42f5mr28680qtw.15.1686623153250; Mon, 12 Jun
 2023 19:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230609033128.ujodex56vkha2ifr@M910t> <CAP-5=fVWhp_cMpgwTRiO+bC7tKKGvKsavRVVDW-k9qYB7ZoXWg@mail.gmail.com>
 <CAP-5=fWRpZSYcuuiSKGL4cS+SDBaSA6GBXJuw-gQAir+4EsagA@mail.gmail.com>
 <20230612021405.kcaccxchmb5juep4@M910t> <CAP-5=fUySkKsAzx-O4-iLsqjhqd53vkx6Wmw+rj5UUrOB88h6A@mail.gmail.com>
 <20230612131042.vkwoaucccwdrhl5a@M910t> <20230612131750.yisfy7zan64beg7y@M910t>
 <CAP-5=fWdvMVOiZDhqiz1R9hucz+6+ho_L3jBixqP3YLcJD7Lew@mail.gmail.com> <20230613022017.wmukzivie4q3gmcp@M910t>
In-Reply-To: <20230613022017.wmukzivie4q3gmcp@M910t>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 12 Jun 2023 19:25:41 -0700
Message-ID: <CAP-5=fUcO1cgBhfYx-4RMBJC=fqMXjaD7jYw6SYvnZ-e+vVN-A@mail.gmail.com>
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

On Mon, Jun 12, 2023 at 7:20=E2=80=AFPM Changbin Du <changbin.du@huawei.com=
> wrote:
>
> On Mon, Jun 12, 2023 at 08:55:14AM -0700, Ian Rogers wrote:
> > On Mon, Jun 12, 2023 at 6:18=E2=80=AFAM Changbin Du <changbin.du@huawei=
.com> wrote:
> >
> > Thanks Changbin, this should have hit the 0x0...0 sentinel match:
> >
> > https://lore.kernel.org/lkml/20230609235419.204624-2-irogers@google.com=
/
> > + } else {
> > + int zero_count =3D 0, non_zero_count =3D 0;
> > +
> > + /* The address should always start 0x. */
> > + if (line_len < 2 || line[0] !=3D '0' || line[1] !=3D 'x')
> > + goto error;
> > +
> > + for (size_t i =3D 2; i < line_len; i++) {
> > + if (line[i] =3D=3D '0')
> > + zero_count++;
> > + else
> > + non_zero_count++;
> > + }
> > + if (!non_zero_count) {
> > + int ch;
> > +
> > + if (!zero_count) {
> > + /* Line was erroneous just '0x'. */
> > + goto error;
> > + }
> > + /*
> > + * Line was 0x0..0, the sentinel for binutils. Remove
> > + * the function and filename lines.
> > + */
> > + zfree(&line);
> > + do {
> > + ch =3D io__get_char(io);
> > + } while (ch > 0 && ch !=3D '\n');
> > + do {
> > + ch =3D io__get_char(io);
> > + } while (ch > 0 && ch !=3D '\n');
> > + return 0;
> > + }
> >   }
> >
> > That doesn't use io__getline - so we've not matched the 0x0...0 case
> > to terminate the records. Could you add some logging/debug?
> >
> I printed every charactor got by io__get_char(), based on previous debug =
change.
> Please see logs below.
>
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> addr2line: /home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6f=
a3776974b54/elf, addr ffffffff81e000aa
> subprocess: addr2line -e /home/changbin/.debug/.build-id/5e/2fa721660d663=
f38b6e1aa98d6fa3776974b54/elf -a -i -f
> io__get_char: '0'
> io__get_char: 'x'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '
> '
> io__get_char: '_'
> io__get_char: '_'
> io__get_char: 'p'
> io__get_char: 'e'
> io__get_char: 'r'
> io__get_char: '_'
> io__get_char: 'c'
> io__get_char: 'p'
> io__get_char: 'u'
> io__get_char: '_'
> io__get_char: 's'
> io__get_char: 't'
> io__get_char: 'a'
> io__get_char: 'r'
> io__get_char: 't'
> io__get_char: '
> '
> io__get_char: '?'
> io__get_char: '?'
> io__get_char: ':'
> io__get_char: '?'
> io__get_char: '
> '
> read_addr2line_record
> io__getline: start
> io__get_char: '0'
> io__get_char: 'x'
> io__get_char: 'f'
> io__get_char: 'f'
> io__get_char: 'f'
> io__get_char: 'f'
> io__get_char: 'f'
> io__get_char: 'f'
> io__get_char: 'f'
> io__get_char: 'f'
> io__get_char: '8'
> io__get_char: '1'
> io__get_char: 'e'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: 'a'
> io__get_char: 'a'
> io__get_char: '
> '
> io__getline: 0xffffffff81e000aa
>
> io__getline: start
> io__get_char: 'e'
> io__get_char: 'n'
> io__get_char: 't'
> io__get_char: 'r'
> io__get_char: 'y'
> io__get_char: '_'
> io__get_char: 'S'
> io__get_char: 'Y'
> io__get_char: 'S'
> io__get_char: 'C'
> io__get_char: 'A'
> io__get_char: 'L'
> io__get_char: 'L'
> io__get_char: '_'
> io__get_char: '6'
> io__get_char: '4'
> io__get_char: '_'
> io__get_char: 'a'
> io__get_char: 'f'
> io__get_char: 't'
> io__get_char: 'e'
> io__get_char: 'r'
> io__get_char: '_'
> io__get_char: 'h'
> io__get_char: 'w'
> io__get_char: 'f'
> io__get_char: 'r'
> io__get_char: 'a'
> io__get_char: 'm'
> io__get_char: 'e'
> io__get_char: '
> '
> io__getline: entry_SYSCALL_64_after_hwframe
>
> io__getline: start
> io__get_char: '?'
> io__get_char: '?'
> io__get_char: ':'
> io__get_char: '?'
> io__get_char: '
> '
> io__getline: ??:?
>
> read_addr2line_record
> io__getline: start
> io__get_char: '0'
> io__get_char: 'x'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '0'
> io__get_char: '
> '
> io__getline: 0x0000000000000000
>
> io__getline: start
> io__get_char: '_'
> io__get_char: '_'
> io__get_char: 'p'
> io__get_char: 'e'
> io__get_char: 'r'
> io__get_char: '_'
> io__get_char: 'c'
> io__get_char: 'p'
> io__get_char: 'u'
> io__get_char: '_'
> io__get_char: 's'
> io__get_char: 't'
> io__get_char: 'a'
> io__get_char: 'r'
> io__get_char: 't'
> io__get_char: '
> '
> io__getline: __per_cpu_start
>
> io__getline: start
> io__get_char: '?'
> io__get_char: '?'
> io__get_char: ':'
> io__get_char: '?'
> io__get_char: '
> '
> io__getline: ??:?
>
> read_addr2line_record
> io__getline: start
> [stuck]


Cool. Looks like the terminating '\n' is the issue. It is specified to
be part of getline. Can you tweak:

+ if (line[i] =3D=3D '0')
+ zero_count++;
+ else
+ non_zero_count++;

to be:

+ if (line[i] =3D=3D '0')
+ zero_count++;
+ else if (line[i] !=3D '\n')
+ non_zero_count++;

Thanks,
Ian

> > Thanks,
> > Ian
> >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Ian
> > > > > > > >
> > > > > > > > > --
> > > > > > > > > Cheers,
> > > > > > > > > Changbin Du
> > > > > >
> > > > > > --
> > > > > > Cheers,
> > > > > > Changbin Du
> > > >
> > > > --
> > > > Cheers,
> > > > Changbin Du
> > >
> > > --
> > > Cheers,
> > > Changbin Du
>
> --
> Cheers,
> Changbin Du
