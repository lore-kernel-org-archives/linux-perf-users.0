From: zhao bao <baozhao@gmail.com>
Subject: Re: Fwd: perf trace cannot work with software events ?
Date: Wed, 30 Mar 2011 01:07:26 +0800
Message-ID: <AANLkTim+3LDEan2O_Aw80hysYXbaXEEmKiocwjw_y=wq@mail.gmail.com>
References: <AANLkTi=pRKpdupEcXS0FmOA-PiAiXHWPYwWxN4F27fFC@mail.gmail.com>
	<AANLkTikXKDiyf7Q=mY_ez2P3OSw23VaRMdKcF_M-KCc0@mail.gmail.com>
	<AANLkTi=VrazJpV+dpzX2hWJ8dYDgbdo_5FAOMRYRo0GD@mail.gmail.com>
	<AANLkTi=A5hkUE0xna5zmuXGt=LvMS_C41whzwM0-nUNs@mail.gmail.com>
	<4D8DE695.3000606@gmail.com>
	<AANLkTiktVqjaaNRm7EaCTJMsYsQnKUWrekDqF4r7YW7=@mail.gmail.com>
	<4D8DF6E4.1070804@gmail.com>
	<AANLkTik4RrEh8wgj+TXB1DYZtfn1Wp3iMiZs-XZBrsRG@mail.gmail.com>
	<4D8EB605.7070407@gmail.com>
	<AANLkTi=JefJqiUdvZ+r+sS25+bbDG_c6M8825xKpSUnu@mail.gmail.com>
	<4D8FA787.7020308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53568 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab1C2RH1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Mar 2011 13:07:27 -0400
Received: by gyd10 with SMTP id 10so160845gyd.19
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Mar 2011 10:07:26 -0700 (PDT)
In-Reply-To: <4D8FA787.7020308@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

2011/3/28 David Ahern <dsahern@gmail.com>:
>
>
> On 03/27/11 01:44, zhao bao wrote:
>> The address I want is the value stored =C2=A0in X86 CR2 register whe=
n page
>> fault =C2=A0occurs, Does perf provide these =C2=A0information?
>
> Add the -d option to perf-record, and try the following change on
> perf-script:
>

Many thanks to you! I hope your patch would be merged into mainline.
