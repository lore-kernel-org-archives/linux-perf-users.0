Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2452C7EE2E
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 02:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbjFMCUp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 22:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjFMCUl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 22:20:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584AD198E
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 19:20:34 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QgByv6QBNzLpqp;
        Tue, 13 Jun 2023 10:17:27 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 10:20:31 +0800
Date:   Tue, 13 Jun 2023 10:20:17 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Ian Rogers <irogers@google.com>
CC:     Changbin Du <changbin.du@huawei.com>,
        <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        <hw.huiwang@huawei.com>
Subject: Re: [Issue] perf report gets stuck at addr2line
Message-ID: <20230613022017.wmukzivie4q3gmcp@M910t>
References: <20230609033128.ujodex56vkha2ifr@M910t>
 <CAP-5=fVWhp_cMpgwTRiO+bC7tKKGvKsavRVVDW-k9qYB7ZoXWg@mail.gmail.com>
 <CAP-5=fWRpZSYcuuiSKGL4cS+SDBaSA6GBXJuw-gQAir+4EsagA@mail.gmail.com>
 <20230612021405.kcaccxchmb5juep4@M910t>
 <CAP-5=fUySkKsAzx-O4-iLsqjhqd53vkx6Wmw+rj5UUrOB88h6A@mail.gmail.com>
 <20230612131042.vkwoaucccwdrhl5a@M910t>
 <20230612131750.yisfy7zan64beg7y@M910t>
 <CAP-5=fWdvMVOiZDhqiz1R9hucz+6+ho_L3jBixqP3YLcJD7Lew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWdvMVOiZDhqiz1R9hucz+6+ho_L3jBixqP3YLcJD7Lew@mail.gmail.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 12, 2023 at 08:55:14AM -0700, Ian Rogers wrote:
> On Mon, Jun 12, 2023 at 6:18 AM Changbin Du <changbin.du@huawei.com> wrote:
> 
> Thanks Changbin, this should have hit the 0x0...0 sentinel match:
> 
> https://lore.kernel.org/lkml/20230609235419.204624-2-irogers@google.com/
> + } else {
> + int zero_count = 0, non_zero_count = 0;
> +
> + /* The address should always start 0x. */
> + if (line_len < 2 || line[0] != '0' || line[1] != 'x')
> + goto error;
> +
> + for (size_t i = 2; i < line_len; i++) {
> + if (line[i] == '0')
> + zero_count++;
> + else
> + non_zero_count++;
> + }
> + if (!non_zero_count) {
> + int ch;
> +
> + if (!zero_count) {
> + /* Line was erroneous just '0x'. */
> + goto error;
> + }
> + /*
> + * Line was 0x0..0, the sentinel for binutils. Remove
> + * the function and filename lines.
> + */
> + zfree(&line);
> + do {
> + ch = io__get_char(io);
> + } while (ch > 0 && ch != '\n');
> + do {
> + ch = io__get_char(io);
> + } while (ch > 0 && ch != '\n');
> + return 0;
> + }
>   }
> 
> That doesn't use io__getline - so we've not matched the 0x0...0 case
> to terminate the records. Could you add some logging/debug?
>
I printed every charactor got by io__get_char(), based on previous debug change.
Please see logs below.

# To display the perf.data header info, please use --header/--header-only options.
#
addr2line: /home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf, addr ffffffff81e000aa
subprocess: addr2line -e /home/changbin/.debug/.build-id/5e/2fa721660d663f38b6e1aa98d6fa3776974b54/elf -a -i -f
io__get_char: '0'
io__get_char: 'x'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '
'
io__get_char: '_'
io__get_char: '_'
io__get_char: 'p'
io__get_char: 'e'
io__get_char: 'r'
io__get_char: '_'
io__get_char: 'c'
io__get_char: 'p'
io__get_char: 'u'
io__get_char: '_'
io__get_char: 's'
io__get_char: 't'
io__get_char: 'a'
io__get_char: 'r'
io__get_char: 't'
io__get_char: '
'
io__get_char: '?'
io__get_char: '?'
io__get_char: ':'
io__get_char: '?'
io__get_char: '
'
read_addr2line_record
io__getline: start
io__get_char: '0'
io__get_char: 'x'
io__get_char: 'f'
io__get_char: 'f'
io__get_char: 'f'
io__get_char: 'f'
io__get_char: 'f'
io__get_char: 'f'
io__get_char: 'f'
io__get_char: 'f'
io__get_char: '8'
io__get_char: '1'
io__get_char: 'e'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: 'a'
io__get_char: 'a'
io__get_char: '
'
io__getline: 0xffffffff81e000aa

io__getline: start
io__get_char: 'e'
io__get_char: 'n'
io__get_char: 't'
io__get_char: 'r'
io__get_char: 'y'
io__get_char: '_'
io__get_char: 'S'
io__get_char: 'Y'
io__get_char: 'S'
io__get_char: 'C'
io__get_char: 'A'
io__get_char: 'L'
io__get_char: 'L'
io__get_char: '_'
io__get_char: '6'
io__get_char: '4'
io__get_char: '_'
io__get_char: 'a'
io__get_char: 'f'
io__get_char: 't'
io__get_char: 'e'
io__get_char: 'r'
io__get_char: '_'
io__get_char: 'h'
io__get_char: 'w'
io__get_char: 'f'
io__get_char: 'r'
io__get_char: 'a'
io__get_char: 'm'
io__get_char: 'e'
io__get_char: '
'
io__getline: entry_SYSCALL_64_after_hwframe

io__getline: start
io__get_char: '?'
io__get_char: '?'
io__get_char: ':'
io__get_char: '?'
io__get_char: '
'
io__getline: ??:?

read_addr2line_record
io__getline: start
io__get_char: '0'
io__get_char: 'x'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '0'
io__get_char: '
'
io__getline: 0x0000000000000000

io__getline: start
io__get_char: '_'
io__get_char: '_'
io__get_char: 'p'
io__get_char: 'e'
io__get_char: 'r'
io__get_char: '_'
io__get_char: 'c'
io__get_char: 'p'
io__get_char: 'u'
io__get_char: '_'
io__get_char: 's'
io__get_char: 't'
io__get_char: 'a'
io__get_char: 'r'
io__get_char: 't'
io__get_char: '
'
io__getline: __per_cpu_start

io__getline: start
io__get_char: '?'
io__get_char: '?'
io__get_char: ':'
io__get_char: '?'
io__get_char: '
'
io__getline: ??:?

read_addr2line_record
io__getline: start
[stuck]

> Thanks,
> Ian
> 
> > > > Thanks,
> > > > Ian
> > > >
> > > > > >
> > > > > > > Thanks,
> > > > > > > Ian
> > > > > > >
> > > > > > > > --
> > > > > > > > Cheers,
> > > > > > > > Changbin Du
> > > > >
> > > > > --
> > > > > Cheers,
> > > > > Changbin Du
> > >
> > > --
> > > Cheers,
> > > Changbin Du
> >
> > --
> > Cheers,
> > Changbin Du

-- 
Cheers,
Changbin Du
