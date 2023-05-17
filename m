Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F2BC77B7D
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 May 2023 16:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEQQXE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 May 2023 12:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjEQQXD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 May 2023 12:23:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8C12D5D
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 09:23:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51452556acdso664800a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684340582; x=1686932582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXXqR7I5i12Ov3x8Dv5PuIE8c3xnsimsk/uQ1kWomhY=;
        b=ew8YD6Kau3MksBgw2uAxZOV1C/tM/XVJqiavM3wAW0axA92Zkv6OrcBXAwXvXMqEH6
         rgBs+KtKvxsd2La5d0/GZlyhfNCCQ4auSdtcGJjArPW08Lqxa2vIVyQikAmqxa8Ukr88
         ANvY0t3HOuuuQZrtGG8QSLf7ap4zlXnkelhj0hxrOtfeIFRyw5bmzxe5rFqdm9kZpYQS
         id7+To6hBKDpFrJMxJokFQDlUdTiyXybHb4IyHYfM204h5HWjk8selxJ1trYqeY39kIt
         e2GdT2rErbT41IjpQlnpjKYz3nhb9lF1OvKMzvSEniVmjzwJhXWWOQfLlDbXOqq9uOWe
         tzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340582; x=1686932582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXXqR7I5i12Ov3x8Dv5PuIE8c3xnsimsk/uQ1kWomhY=;
        b=ZsgO0vmlT+vyMyxI8jz8+9d5LEmGTte1NGEeKBguJfH/VMgGWoRUCk1enf0jaWomDP
         1RsIgglqLwW/TPNQ7sTgX3U5t690cG6pAKpvNrd0ZGvca5yE1GwYjVSTWrEU1e76P5ik
         Fsi8eoJX78l88lqNR8nT1w+V0E8Lu+GwEprPWUejoejt99M1dTAj+uneslVvC+F/Zodn
         wGr3QR/tAYEcUVWEAyb+6YuAGBr9BbmUbwEi/UK3P0/W8A58ZEKzO1VpZA9LxQEZMUry
         XfvbPkeQtkHbTqLJW33HTlLgk1t3MprmKVi0tW4TR+hjeukdx9s60liaq7D3znXGYcUj
         DaNg==
X-Gm-Message-State: AC+VfDya5UqWWOPEG0CE1sqyZBvoE+CCjD4IveESks8Ug90FNYxwPvrz
        jJSS9DMhFCOGpBjV+ZCXal1Nyr5kQU9/Qgz8m/pjxoRyd+s=
X-Google-Smtp-Source: ACHHUZ79+QmQJFmRjvzVSC8GCEtrVnjMyuSAZXbtE0zKSriB7DqX+6rfdv2Rfj42yRzNzp67Z71H5Azn60UdV1H5gSw=
X-Received: by 2002:a17:902:9a04:b0:1ad:bccc:af78 with SMTP id
 v4-20020a1709029a0400b001adbcccaf78mr26733036plp.58.1684340581611; Wed, 17
 May 2023 09:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAGA5_H6b7jVJcy0ahnbTqG3eqA2PD3TGFmXm7xQ=gMBVJ1yZyg@mail.gmail.com>
 <CAGA5_H7CBGiaaULrbhQk1P8qQC5BKBOK54pEGnppggY892MWSw@mail.gmail.com> <CAOX+pvZhy8n6Konmgrr7Ur=4zNQPibG8uy4hLjidtQ-t6XwgQA@mail.gmail.com>
In-Reply-To: <CAOX+pvZhy8n6Konmgrr7Ur=4zNQPibG8uy4hLjidtQ-t6XwgQA@mail.gmail.com>
From:   Rajasekhar Pulluru <pullururajasekhar@gmail.com>
Date:   Wed, 17 May 2023 21:52:49 +0530
Message-ID: <CAGA5_H5BNHmzFx2ubKw0XVUpk25nFGz+1_fRvRWSPNN9Nxek6w@mail.gmail.com>
Subject: Re: missing symbol names in perf top but not in perf record/report
To:     Bipul Kumar <bipul.personal7@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Rajasekhar Pulluru <pullururajasekhar@gmail.com>

9:44=E2=80=AFPM (7 minutes ago)
to Bipul, linux-perf-users
Hi Bipul,

Thanks for the response, appreciate it.

Here are the steps I followed,
1) start docker container
ubuntu:jammy# docker run -it ubuntu:bionic bash

2) start application
root@2839de927657:/#/root/test-app &
#test-app is a daemon and runs continuously

3) go back to host
root@2839de927657:/# exit
ubuntu:jammy#

4) run perf top on test-app
ubuntu:jammy# perf top -p `pidof test-app`
#perf top doesn't display test-app function names but instead only
displays function addresses in hex.

5) run perf record and report displays function names and not its address(h=
ex).
ubuntu:jammy# perf record -p `pidof test-app`
ctrl+c
ubuntu:jammy# perf report

If perf record/report can display function names why not perf top
display function names on the same application?

Thanks & Regards,
Rajasekhar


On Mon, May 15, 2023 at 11:23=E2=80=AFPM Bipul Kumar <bipul.personal7@gmail=
.com> wrote:
>
> > An application (compiled with -g and -fno-omit-frame-pointer) is
> > running inside the linux container. Trying to use perf tool on the
> > linux host (not inside the container) to identify a list of functions
> > consuming more cpu cycles.
> > Running perf top -p `pidof app` on the linux host prints address
> > instead of symbol name, where-as perf record -p `pidof app` and perf
> > report prints symbol names instead of addresses.
>
> Can you show me the process of how you are doing?
>
> > Why doesn't perf top display symbol names if perf record/report can?
> >
> > Linux host is based on jammy, and Linux container is based on bionic.
>
> Anyway the behavior you described may be because of  different techniques=
 used by these perf commands to collect and display data.
> When you run perf record, it collects profiling data by sampling the prog=
ram's execution at regular intervals and when you run  perf top   `pidof ap=
p`  ,
> it operates in real-time, continuously monitoring the program's execution=
.
> Please note that my comments are based on my assumptions  without examini=
ng the details, I am unable to provide any further insights
>
> Thank you.
>
> Respectfully,
> Bipul
>
>
>
> Computer Programmer
>
>
>    ** Please excuse brevity and typos. **
>
> -----BEGIN PGP PUBLIC KEY BLOCK-----
>
> mQGNBGRCE80BDADK24G3fgE/5zVbfbWvnPaOhmTvoGXGdzOwZlShd1eEtppGzzHf
> 4Khi/nvarTsWinO0wE3265aurll7aJVADrL7rfOt3yeu6D8z8wDrb0zxkHfir7EE
> JNVEOTl8pS4HRX0SmhpaDTNr5+3ZMbRz0tfB6asWuBcw8qHqk303b4dPcA5ZRA9Z
> zMsKiki1bbVH+1cnblmgmo7mDHSiwoT1IvBjDXFmfiMM5JqWe9wgI21xMfM+ql9z
> Dg7IUGGOT+ulbrbWLWr3LBQhdDnmZUJnkNtZfU0cJVflv5yCZ7ZKZpeCbKn9rXMa
> Rvh8KR9siSd1Vh6vfQC9E3+G/duv0NHrEwAh8oif3fxUAyg1LEhbsjEYIBZ3tvOT
> OaQFuw2xcZrhZHseFFw1JWYkFpBc3CTSjlhe6umGJili8myMJ1yVKlYt0pay3OaM
> 3KFbckuOtKIY7wYpICWDXXkHd3q3lWlyGiYA3WjKwOYcBOTzljguH+5ucqPEKKZ+
> ogsiPlArTEBeb/MAEQEAAbRHQmlwdWwga3VtYXIgKFNlbmQgeW91ciBoaWRkZW4g
> aW5mb3JtYXRpb24pIDxiaXB1bC5vcGVuc291cmNlQGdtYWlsLmNvbT6JAc4EEwEK
> ADgWIQQRDZfGcmT7xYwq+Qk1zUEYDBqMaQUCZEITzQIbAwULCQgHAgYVCgkICwIE
> FgIDAQIeAQIXgAAKCRA1zUEYDBqMaV4EC/0QK9OTJtr677h3b8B6dLAjvI7T649I
> d+0dD3Zg6HjMf0ZRdZ+qP53ZUVQApVnQqBWrN5TT4r8d28C+QJ8dpJGy/plqmJzT
> CQRakMtnHj6bq88/Q8RlJSwQUcm0PCMdTRAMGU0JvDYN6SwIuBIi5gOkAjHLczHr
> FIzVPKqaUJRfz/TPb0HeX/sIU7tjXhwrayi8Gq57FpMx0imLDqjFNvSVR5jjg8gy
> BxxrF4jk2DJoZsrh/rNBUWjwxGvV2ZaPfBNZI+o50B91y5w90UQCgFODlb5czj5x
> CIIdLW8ogBgo5Eoxn9VCbzTykbt/xvpMyp99YOywWaDhBzhaDWlNaVAav0/HEGNL
> PJH4PoKJ6oIUOyukFFABtq3KdRae2pew2TT5lLTLR8cMmCPGRp6yV2i2Xd4SFag4
> 316FZnNvDvesbbzTTZq9IcKChdBDrW44hI7j2nqv8fRUbsjMYbuVUTnJnBTZdUyy
> SPkG/qfu++Nz8qFKDpeRby4QqsNylUOGwua5AY0EZEITzQEMAK2JpRs21teE5ZgO
> H0OBWMXWPPbYYdPP6Ht2wqa1VdiCbGdHD1WpIza2Ny9zAOTjsRPVyaIYlEM0zteU
> jJK9jDC73nvUEMkddBXtDO/qNGkS8ZffxmzcKdvybdYcNHIlsnVXjtXkbDhVzSex
> RmBhW+dPOlZqZCdgr7uBTviz6Jnhh8c6I0i1CD+RnSrvw9Di91dZQZLhslTjzDe/
> nCOcsy2wst4uIrUZCFAhpGK97KoSRLw3u3+UHwONxM3/MnbXxgF/LfDjQWvwsdgt
> EqOv5WBhrAMa2jMgaabIB5qn5jcYDvLE+Kr6Wabu4kXDCBpD6PRxS1k+VDHpD/Z7
> 7onW6DGGSv9wd5ape5GLeiXy4A9C7yd5ZyX7AY7p6smfvYWTebcxkAnloENpeZzV
> ZaHaemLkLPybmnEY0UUIKFae7lPv4V1q2G9LYTeCOEaJVfGeMAWSqvQRjEMSzNQC
> p3NU+ROlZHOM7ofjw0l6uumF/SBZNRjxBhtgmZ6/2zOfHpFpeQARAQABiQG2BBgB
> CgAgFiEEEQ2XxnJk+8WMKvkJNc1BGAwajGkFAmRCE80CGwwACgkQNc1BGAwajGng
> OgwAwoPOfggKlXESk9F50u9oEEF9HCoyQEi13tEYwJGZiAgcfp52oofpw69Q8E6u
> U85evj0NKKbir64XZzjUd+l4em4ADd5LOSP1RXhe0yVR/8Yg0VGzWh3diNWOa7SV
> LmC+lr/SgehbK51e8YsgLkSKoJIxQZEUYJ53Viw2/1AYETJXQash9DxR/LeCTIqC
> jIXWCeDumsZfr0DZnCL0l/x/O70YWRtGpDQ2R904EU9f47sKpq4mCtWR9dNaK0J1
> h0Ug0XBibucELVgm+TFCW0f5s2AVa176kJqv9UjO6J3TC3lc3iCc6KTwiiX5V+7D
> 5gIsa7b7V4N3XswT2XNn5GMIuHqHnqrcA3lDDK2Xuq7zdZcUsBK3kH9EEaW2LrJq
> CCU1UtyMAKj3vUPCXhUkTeIjUXt8iczqwMaJuLHIT/B9W1zRddOzsqzWd8dNodr1
> 9UdMUa3jMNdrbARirbzqahBDhCOnXJyhnyR4Z2Bklom4/PJHRni31bNS6J8FHkpL
> 1Y5q
> =3DKI50
> -----END PGP PUBLIC KEY BLOCK-----
>
>
>
>                       ** Please excuse brevity and typos. **
>
>
> On Mon, May 15, 2023 at 10:52=E2=80=AFPM Rajasekhar Pulluru <pullururajas=
ekhar@gmail.com> wrote:
>>
>> Hi Team,
>> Will be glad to see some help on the issue reported below.
>> Is this an expected behaviour? Is there a known solution to this problem=
?
>>
>> Thanks & Regards,
>> Rajasekhar
>>
>> On Thu, May 11, 2023 at 11:05=E2=80=AFAM Rajasekhar Pulluru
>> <pullururajasekhar@gmail.com> wrote:
>> >
>> > An application (compiled with -g and -fno-omit-frame-pointer) is
>> > running inside the linux container. Trying to use perf tool on the
>> > linux host (not inside the container) to identify a list of functions
>> > consuming more cpu cycles.
>> > Running perf top -p `pidof app` on the linux host prints address
>> > instead of symbol name, where-as perf record -p `pidof app` and perf
>> > report prints symbol names instead of addresses.
>> >
>> > Why doesn't perf top display symbol names if perf record/report can?
>> >
>> > Linux host is based on jammy, and Linux container is based on bionic.
>> >
>> > Appreciate any help.
>> >
>> > Thanks & Regards,
>> > Rajasekhar
