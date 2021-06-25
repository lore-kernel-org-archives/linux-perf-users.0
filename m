Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1425EC2B9F4
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 10:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0E561441
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Jun 2021 10:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhFYKgl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Jun 2021 06:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230379AbhFYKgl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Jun 2021 06:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624617260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=VbWwhh/UE1DxcplrUjD5TchhvCA/9uVeg7zpbYI5jw8=;
        b=TVdDjN6DtZNxeYeoB9p0kdy+Cg4AbchvgoN/FlyRWDrPcmNm9CU4Wnfosk0ArtjYMrbtHO
        Cdqa2LuVYIjgF6t9qVInV/mXB4LndQvxGnbGpWb8Yib9iwBM5I09y8Q2YFVY2UT78SmSjy
        hZvBdP+3kPH4aLUkC+2BJ7tSnyftQTc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-CVhq44SHNf21xGUcH9q9Fg-1; Fri, 25 Jun 2021 06:34:19 -0400
X-MC-Unique: CVhq44SHNf21xGUcH9q9Fg-1
Received: by mail-ej1-f69.google.com with SMTP id jw19-20020a17090776b3b0290481592f1fc4so2963253ejc.2
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jun 2021 03:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=VbWwhh/UE1DxcplrUjD5TchhvCA/9uVeg7zpbYI5jw8=;
        b=t0zu4i/Ysh1mg9R1s2g4agnl7/wTcoBX/BkkDsWipEYAZ1W/oH1f3BLO4/XUcAwcSC
         IX2DJ5IhNrxat3iN+z3MYKeAX1jIVFOnZqFZPGJwdvebsn2xJrdkFffdg00/yLhGp+lc
         HESR6n1yYPwx7QgZrUcwhfqUP53siicdCnS2/DPfOh4g32iPpq7nJ18LA2AvFT5ksNU2
         3xxXxTSbY7dbZ6nIeDn/Up7ZLrvs6xtwWQLThnDtpbgdPmdvsZ3S8PMgMtKisOstBhep
         pBJAyFFHBjRwVhnc7dJIvFYYgu4j9sJUueBSCSHGdBu0rzcIdMF62aRWqee1ipXvNz7d
         JOSA==
X-Gm-Message-State: AOAM531EY1mqHCQuOyO31que0JC/WGGHFaQ31UxCB01JGA4rtPlhNldV
        SzTpbVoYjvrOgT2WsIYfYcr54jDae37SLPltcLsILFRPtQXrx+daPJ6OqebdjmQ7KgX2WxYZ9+r
        IPvxhc991EMwCVPVTzAzBb6g7eYN2og==
X-Received: by 2002:a17:906:9452:: with SMTP id z18mr10187823ejx.227.1624617257794;
        Fri, 25 Jun 2021 03:34:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbxYcrpD8gKf6iDI1kPKnl2CjqeT87p8xJtiaB7yS6GH7+TtENi3Qdq9EIcQpflIWWQdafbw==
X-Received: by 2002:a17:906:9452:: with SMTP id z18mr10187789ejx.227.1624617257413;
        Fri, 25 Jun 2021 03:34:17 -0700 (PDT)
Received: from krava ([5.171.190.148])
        by smtp.gmail.com with ESMTPSA id s13sm978264ejm.63.2021.06.25.03.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 03:34:17 -0700 (PDT)
Date:   Fri, 25 Jun 2021 12:34:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf test case probe libc fails with latest Fedora34 glibc update
Message-ID: <YNWxJqxE5nOXBu3I@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cae863a4-bf83-f87b-6e71-b6a544678cae@linux.ibm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 23, 2021 at 04:21:17PM +0200, Thomas Richter wrote:
> I just updated Fedora34 to the latest level and discovered that perf test 78 fails:
> [root@m46lp22 perf]# ./perf test 78
> 78: probe libc's inet_pton & backtrace it with ping                 : FAILED!
> [root@m46lp22 perf]#
> 
> It boils down to this command and happens after glibc is update to level 2.33-18.
> 
> [root@f34 ~]# perf probe -f -x /usr/lib64/libc-2.33.so -a inet_pton
> Probe point 'inet_pton' not found.
>   Error: Failed to add events.
> [root@f34 ~]# rpm -qa | fgrep glibc
> glibc-all-langpacks-2.33-18.fc34.x86_64
> glibc-common-2.33-18.fc34.x86_64
> glibc-langpack-en-2.33-18.fc34.x86_64
> glibc-2.33-18.fc34.x86_64
> glibc-doc-2.33-18.fc34.noarch
> glibc-headers-x86-2.33-18.fc34.noarch
> glibc-devel-2.33-18.fc34.x86_64
> glibc-debugsource-2.33-18.fc34.x86_64
> glibc-debuginfo-2.33-18.fc34.x86_64
> [root@f34 ~]# 
> 
> The symbol inet_pton is now in the .dynsym section of glibc:
> [root@f34 ~]# readelf -sW /usr/lib64/libc-2.33.so | egrep '(dynsym|symtab|inet_pton)'
> Symbol table '.dynsym' contains 2419 entries:
>    628: 000000000011ea00   108 FUNC    WEAK   DEFAULT   15 inet_pton@@GLIBC_2.2.5
>   2251: 000000000011e9b0    76 FUNC    GLOBAL DEFAULT   15 __inet_pton_length@@GLIBC_PRIVATE
> Symbol table '.symtab' contains 104 entries:
> [root@f34 ~]#
> 
> The .symtab section does not contain symbol inet_pton. It contains very few symbols
> compared to previous versions.
> 
> Now perf does not find it. In the older version of the library the
> symbol inet_pton was listed in the .symtab section. Here is the output from version 2.32-4:
> 
> 
> [root@m35lp76 ~]# rpm -qa | fgrep glibc
> glibc-common-2.32-4.fc33.s390x
> glibc-langpack-en-2.32-4.fc33.s390x
> glibc-2.32-4.fc33.s390x
> glibc-headers-s390-2.32-4.fc33.noarch
> glibc-devel-2.32-4.fc33.s390x
> glibc-debuginfo-common-2.32-4.fc33.s390x
> glibc-debuginfo-2.32-4.fc33.s390x
> [root@m35lp76 ~]# 
> 
> 
> readelf -sW /usr/lib64/libc-2.32.so | egrep '(dynsym|symtab|inet_pton)'
> Symbol table '.dynsym' contains 2604 entries:
>    668: 00000000001444b0   788 FUNC    WEAK   DEFAULT   13 inet_pton@@GLIBC_2.2
>   2418: 00000000001441b0   764 FUNC    GLOBAL DEFAULT   13 __inet_pton_length@@GLIBC_PRIVATE
> Symbol table '.symtab' contains 28858 entries:
>  20655: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS inet_pton.c
>  20656: 00000000001440b0     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c
>  20657: 00000000001447c4     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end
>  20658: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.hot
>  20659: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.hot
>  20660: 000000000002b938     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.unlikely
>  20661: 000000000002b938     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.unlikely
>  20662: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.startup
>  20663: 000000000002ba70     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.startup
>  20664: 000000000002b968     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c.exit
>  20665: 000000000002b968     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton.c_end.exit
>  20666: 00000000001440b0     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton4.start
>  20667: 00000000001441aa     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_inet_pton4.end
>  20668: 00000000001440b0   250 FUNC    LOCAL  DEFAULT   13 inet_pton4
>  20669: 00000000001441aa     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton_length.start
>  20670: 00000000001444ac     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton_length.end
>  20671: 00000000001444ac     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton.start
>  20672: 00000000001447c4     0 NOTYPE  LOCAL  HIDDEN    13 .annobin___GI___inet_pton.end
>  23591: 00000000001441b0   764 FUNC    LOCAL  DEFAULT   13 __GI___inet_pton_length
>  23871: 00000000001444b0   788 FUNC    LOCAL  DEFAULT   13 __inet_pton
>  24506: 00000000001444b0   788 FUNC    LOCAL  DEFAULT   13 __GI___inet_pton
>  25831: 00000000001444b0   788 FUNC    LOCAL  DEFAULT   13 __GI_inet_pton
>  26410: 00000000001441b0   764 FUNC    GLOBAL DEFAULT   13 __inet_pton_length
>  27288: 00000000001444b0   788 FUNC    WEAK   DEFAULT   13 inet_pton
> [root@m35lp76 ~]#
> 
> And perf could find the symbol, extract its address and install a probe
> on that address.
> So is this a bug related to the perf tool because it can not handle .dynsym section?
> Or is it releated to glibc's rework?

hi,
there's already glibc bug for that:
  https://bugzilla.redhat.com/show_bug.cgi?id=1975895

looks like they might restore the old behaviour

on the other hand, we could consider to read multiple
symbol tables and merge them together

I'm not sure there's some hidden issue in such approach,
otherwise we might be doing that already ;-)

jirka

