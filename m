Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E66C43219
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 01:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E51CD6324A
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 01:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352560AbhKPBjS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 20:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbhKOScU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 13:32:20 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670D2C04A186;
        Mon, 15 Nov 2021 09:46:01 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id i6so36577591uae.6;
        Mon, 15 Nov 2021 09:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=sZywcLSDmIQPbI6r1LbyMv5+Wpsnx09V/Ks0vRfdKnE=;
        b=hktlfPgCOnIbxTUxtV8RbkbUZmrGA/0N2oRbhlVSVTyX/NWn3cAnLcwe1cP9PZ0EX2
         e6jkbh757dnIOPhR0ZdS7e/dH0BigR3CSxeifpnTX8PIlXEva19RXx+DUbcAY/9DC562
         vPIyIKXWvyzXx8WgZacpvwPVdf0tgqB1hvs9BMOJLO8nr7bu2ISl+H32Oc0tsHgHXzAB
         X3lMkfTumdjKJ/jCbnLnC8sfMJpN6FB31OrYHS7BT5BEJ9qAoT4mZjcvUueLXT8AXZhd
         lwoVOO7l+75XplYfrQay23xJgrEFQ0TQcoUrfh0xt7CXZ8yFSompmrIBTlRw3xdElYSU
         S6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=sZywcLSDmIQPbI6r1LbyMv5+Wpsnx09V/Ks0vRfdKnE=;
        b=IHXX74LGzeM+/rxLbztU9mc0sYarQRWlk2bRp5XIDKhOPF5sjm95Lna/a+bP++PSQI
         EkjmP/OjBMMmey9QipL0W0AsCXV4PchuMwWYZnHOa/ShfYFR2W+6XDoJnvzHq7TJ1hLK
         D4mQAXrUIT0vVkqPArupfvV58ixpbrI3hDG06mjd+G/E+rASR/BTJJ++J0S3illAAInL
         owczu8nBi+6Qcubj1UCnARwZcgk9lXvosNivEfpvMsqIkPODUcbuBI60NFMQ6I8ifEQs
         tE3+24fiVGI5tHMJp8Mj+zue3HCew40pX3d9yYCTqOQZglZR8Q4c/hqZhPZC9VsAC716
         U3Pg==
X-Gm-Message-State: AOAM531fpywQtDvQ4fIvVFZtsbZN+EwdTFPFiCYACdMWsj5no6SS38Q4
        /8xyDrjp/jFFSpIZf9MqKe4=
X-Google-Smtp-Source: ABdhPJxzTxW2CXoaJP9CO+GNDzoKF40lGOZ7Tnkjg84p9LUajN28B9HytJ4mNxi22WWir7YP7ItbLw==
X-Received: by 2002:a05:6102:e07:: with SMTP id o7mr45987356vst.27.1636998360126;
        Mon, 15 Nov 2021 09:46:00 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t5sm9649586vsk.24.2021.11.15.09.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 09:45:58 -0800 (PST)
Date:   Mon, 15 Nov 2021 14:44:59 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        jolsa@redhat.com, masahiroy@kernel.org,
        Laura Abbott <labbott@kernel.org>
CC:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com
Subject: Re: [PATCH] perf tools: Enable warnings through HOSTCFLAGS
User-Agent: K-9 Mail for Android
In-Reply-To: <591edce2-5aaa-22bc-6fd3-5a247f623eb3@huawei.com>
References: <1635525041-151876-1-git-send-email-john.garry@huawei.com> <YYbXMd3N4+aXYLTJ@kernel.org> <591edce2-5aaa-22bc-6fd3-5a247f623eb3@huawei.com>
Message-ID: <239840A9-F713-4FED-B638-14D6B91FBBF2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On November 15, 2021 12:53:33 PM GMT-03:00, John Garry <john=2Egarry@huawe=
i=2Ecom> wrote:
>On 06/11/2021 19:27, Arnaldo Carvalho de Melo wrote:
>> Em Sat, Oct 30, 2021 at 12:30:41AM +0800, John Garry escreveu:
>>> The tools build system uses KBUILD_HOSTCFLAGS symbol for obvious purpo=
ses=2E
>>>
>>> However this is not set for anything under tools/
>>>
>>> As such, host tools apps built have no compiler warnings enabled=2E
>>>
>>> Declare HOSTCFLAGS for perf tools build, and also use that symbol in
>>> declaration of host_c_flags=2E HOSTCFLAGS comes from EXTRA_WARNINGS, w=
hich
>>> is independent of target platform/arch warning flags=2E
>>>
>>> Suggested-by: Jiri Olsa <jolsa@redhat=2Ecom>
>>> Signed-off-by: John Garry <john=2Egarry@huawei=2Ecom>
>>> --
>>> Using HOSTCFLAGS, as opposed to KBUILD_HOSTCFLAGS, is going opposite
>>> direction to commit 96f14fe738b6 ("kbuild: Rename HOSTCFLAGS to
>>> KBUILD_HOSTCFLAGS"), so would like further opinion from Laura and
>>> Masahiro=2E
>>=20
>> Laura's redhat e-mail bouncedm updated it to her kernel=2Eorg one, Laur=
a,
>> Masahiro, would you please comment? Jiri?
>
>Any opinion on this one? Shall I just resend =2E=2E=2E ? or just apply it=
 if=20
>no one cares too much :)

I'll apply it now that everybody got enough time to review it =2E :-)

- Arnaldo
>
>Thanks,
>John
>
>>=20
>> - Arnaldo
>>  =20
>>> diff --git a/tools/build/Build=2Einclude b/tools/build/Build=2Einclude
>>> index 2cf3b1bde86e=2E=2Ec2a95ab47379 100644
>>> --- a/tools/build/Build=2Einclude
>>> +++ b/tools/build/Build=2Einclude
>>> @@ -99,7 +99,7 @@ cxx_flags =3D -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLA=
GS) -D"BUILD_STR(s)=3D\#s" $(CXX
>>>   ###
>>>   ## HOSTCC C flags
>>>  =20
>>> -host_c_flags =3D -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -=
D"BUILD_STR(s)=3D\#s" $(HOSTCFLAGS_$(basetarget)=2Eo) $(HOSTCFLAGS_$(obj))
>>> +host_c_flags =3D -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD=
_STR(s)=3D\#s" $(HOSTCFLAGS_$(basetarget)=2Eo) $(HOSTCFLAGS_$(obj))
>>>  =20
>>>   # output directory for tests below
>>>   TMPOUT =3D =2Etmp_$$$$
>>> diff --git a/tools/perf/Makefile=2Econfig b/tools/perf/Makefile=2Econf=
ig
>>> index 4a9baed28f2e=2E=2E9b95ba09657f 100644
>>> --- a/tools/perf/Makefile=2Econfig
>>> +++ b/tools/perf/Makefile=2Econfig
>>> @@ -17,6 +17,7 @@ detected     =3D $(shell echo "$(1)=3Dy"       >> $(=
OUTPUT)=2Econfig-detected)
>>>   detected_var =3D $(shell echo "$(1)=3D$($(1))" >> $(OUTPUT)=2Econfig=
-detected)
>>>  =20
>>>   CFLAGS :=3D $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WA=
RNINGS))
>>> +HOSTCFLAGS :=3D $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>>>  =20
>>>   include $(srctree)/tools/scripts/Makefile=2Earch
>>>  =20
>>> @@ -211,6 +212,7 @@ endif
>>>   ifneq ($(WERROR),0)
>>>     CORE_CFLAGS +=3D -Werror
>>>     CXXFLAGS +=3D -Werror
>>> +  HOSTCFLAGS +=3D -Werror
>>>   endif
>>>  =20
>>>   ifndef DEBUG
>>> @@ -292,6 +294,9 @@ CXXFLAGS +=3D -ggdb3
>>>   CXXFLAGS +=3D -funwind-tables
>>>   CXXFLAGS +=3D -Wno-strict-aliasing
>>>  =20
>>> +HOSTCFLAGS +=3D -Wall
>>> +HOSTCFLAGS +=3D -Wextra
>>> +
>>>   # Enforce a non-executable stack, as we may regress (again) in the f=
uture by
>>>   # adding assembler files missing the =2EGNU-stack linker note=2E
>>>   LDFLAGS +=3D -Wl,-z,noexecstack
>>> diff --git a/tools/perf/Makefile=2Eperf b/tools/perf/Makefile=2Eperf
>>> index a3966f290297=2E=2E8ca656aa8b06 100644
>>> --- a/tools/perf/Makefile=2Eperf
>>> +++ b/tools/perf/Makefile=2Eperf
>>> @@ -226,7 +226,7 @@ else
>>>   endif
>>>  =20
>>>   export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX A=
WK
>>> -export HOSTCC HOSTLD HOSTAR
>>> +export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
>>>  =20
>>>   include $(srctree)/tools/build/Makefile=2Einclude
>>>  =20
>>> --=20
>>> 2=2E17=2E1
>>=20
>
