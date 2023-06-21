Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AD7EB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 04:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjFUEff convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 00:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFUEfe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 00:35:34 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2B93172C
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jun 2023 21:35:31 -0700 (PDT)
Received: from loongson.cn (unknown [209.85.218.53])
        by gateway (Coremail) with SMTP id _____8DxtfAPfpJkOgAAAA--.19S3;
        Wed, 21 Jun 2023 12:35:28 +0800 (CST)
Received: from mail-ej1-f53.google.com (unknown [209.85.218.53])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c7ReZJkBAEAAA--.36S3;
        Wed, 21 Jun 2023 12:17:22 +0800 (CST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-98746d7f35dso693365266b.2
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jun 2023 21:17:22 -0700 (PDT)
X-Gm-Message-State: AC+VfDwcH5XrQmw7/+S5kHatkbG8t74z3sBxgQIUTnvaDYoneNnTmcST
        kb6tzhtUElBSDWdH4i456vBjm4IKkSc9ul4z7Anq8Q==
X-Google-Smtp-Source: ACHHUZ4NbyRZWvmfN8G6zN4spULubzWBpkQQU1JsvmeAsqFQhaJ3lcgXL/QS2HBeY7kvekKVIU/OcmeCEJbFA6zurcA=
X-Received: by 2002:adf:f08b:0:b0:311:1ce2:ee1b with SMTP id
 n11-20020adff08b000000b003111ce2ee1bmr10295436wro.66.1687320634966; Tue, 20
 Jun 2023 21:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230620132025.105563-1-wangrui@loongson.cn> <CAM9d7chjhFNjDMADJTTz5TNgCCuyPzy8VCDvZxw5K5girfWu1A@mail.gmail.com>
In-Reply-To: <CAM9d7chjhFNjDMADJTTz5TNgCCuyPzy8VCDvZxw5K5girfWu1A@mail.gmail.com>
From:   WANG Rui <wangrui@loongson.cn>
Date:   Wed, 21 Jun 2023 12:10:24 +0800
X-Gmail-Original-Message-ID: <CAHirt9hDc-22AKrRZEEUW9LUa3hjmnEVrYDNyWCx4kkWU4WzXA@mail.gmail.com>
Message-ID: <CAHirt9hDc-22AKrRZEEUW9LUa3hjmnEVrYDNyWCx4kkWU4WzXA@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix instruction association and parsing
 for LoongArch
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, Tiezhu Yang <yangtiezhu@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: AQAAf8Cx_c7ReZJkBAEAAA--.36S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WryxAw4rXr4fAr4DWrWDWrX_yoW8Cr1Dpa
        4Iy3WxWr4xtry8CwsrJay8Z3ZxCw13WrW3A3s7tas8CFn8uF4fGa45KFyaka45Ar17Wr40
        vF4DZryFkrnrtFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Jr0_Gr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
        CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
        4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
        k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
        6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jb6pPUUUUU=
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Namhyung,

On Wed, Jun 21, 2023 at 2:42 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > +static int loongarch_call__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms)
> > +{
> > +       char *c, *endptr, *tok, *name;
> > +       struct map *map = ms->map;
> > +       struct addr_map_symbol target = {
> > +               .ms = { .map = map, },
>
> Looking here...
>
> > +       };
> > +
> > +       c = strchr(ops->raw, '#');
> > +       if (c++ == NULL)
> > +               return -1;
> > +
> > +       ops->target.addr = strtoull(c, &endptr, 16);
> > +
> > +       name = strchr(endptr, '<');
> > +       name++;
> > +
> > +       if (arch->objdump.skip_functions_char &&
> > +           strchr(name, arch->objdump.skip_functions_char))
> > +               return -1;
> > +
> > +       tok = strchr(name, '>');
> > +       if (tok == NULL)
> > +               return -1;
> > +
> > +       *tok = '\0';
> > +       ops->target.name = strdup(name);
> > +       *tok = '>';
> > +
> > +       if (ops->target.name == NULL)
> > +               return -1;
> > +
> > +       target.addr = map__objdump_2mem(map, ops->target.addr);
> > +
> > +       if (maps__find_ams(ms->maps, &target) == 0 &&
> > +           map__rip_2objdump(target.ms.map, map__map_ip(target.ms.map, target.addr)) == ops->target.addr)
>
> So the target.ms.map is 'map', right?  Then we can reduce the line.

toos/perf/util/maps.c:

> int maps__find_ams(struct maps *maps, struct addr_map_symbol *ams)
> {
>     if (ams->addr < map__start(ams->ms.map) || ams->addr >= map__end(ams->ms.map)) {
>         if (maps == NULL)
>             return -1;
>         ams->ms.map = maps__find(maps, ams->addr);

Is it possible that `target.ms.map` might be reassigned within the
`maps_find_ams` function in this case?

>         if (ams->ms.map == NULL)
>             return -1;
>     }
>
>     ams->al_addr = map__map_ip(ams->ms.map, ams->addr);
>     ams->ms.sym = map__find_symbol(ams->ms.map, ams->al_addr);
>
>     return ams->ms.sym ? 0 : -1;
> }

Thanks!

-- 
WANG Rui
Loongson Technology Corporation Limited

