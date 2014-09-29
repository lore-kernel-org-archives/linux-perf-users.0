From: Tong Shen <endlessroad@google.com>
Subject: Re: [PATCH 1/1] perf tools: Fix Symbol Address for ET_DYN
Date: Mon, 29 Sep 2014 11:13:13 -0700
Message-ID: <CAPp4yYxVSUMBBXdVPUETu=uM2K5P9GoeQjH0YgayVL2qco-gYg@mail.gmail.com>
References: <CAPp4yYwTHbXiypxR_1WJGS9DYQNJ24t_Ykdo_sfQ48Ak-K3Z7g@mail.gmail.com>
	<20140911150123.GH10158@kernel.org>
	<CAPp4yYzRwoTBzH1_TwcdvAOryZppV9-BwnX2bOtN1qrEqrdBww@mail.gmail.com>
	<20140911203806.GA25763@kernel.org>
	<CAPp4yYzT66+J_dHC5_0TiTEdSK874OS-PH9nAtcr5-Luj69+7w@mail.gmail.com>
	<CAPp4yYxripyJvr87TtVqNMi5=K+UQGeKTomQiJarFnVGyjtofA@mail.gmail.com>
	<87fvffj5o0.fsf@sejong.aot.lge.com>
	<CAPp4yYzPR-FozYeuDUFqR0hhE5tioSqNy22cZ7WjSdBXoxeNxw@mail.gmail.com>
	<87ppefi29s.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:54041 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969AbaI2SNP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 29 Sep 2014 14:13:15 -0400
Received: by mail-la0-f44.google.com with SMTP id gi9so8372113lab.3
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2014 11:13:14 -0700 (PDT)
In-Reply-To: <87ppefi29s.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Sep 28, 2014 at 7:33 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hmm.. IIUC for normal dso (ET_DYN), shdr->offset == shdr->sh_addr for
> text section right?  And we always adjust ET_EXEC and ET_REL..  What
> about always trying to adjust symbol address then?  We may precalculate
> adjust offset and subtracting it from symbol values.  And the offset of
> 0 effectively means no adjust.  This way we can simplify the logic IMHO.

Yeah I'd like to do that too; but (shdr->offset == shdr->sh_addr for
normal ET_DYN && shdr->offset != shdr->sh_addr for non-relocatable
ET_DYN) is only true for .text section. It does not hold for .data
section.


I didn't dig deep into the code; if we only care about symbols in
.text section (function names), we can do what you said. Otherwise we
may want to keep it the way it is...

-- 
Best Regards, Tong Shen
