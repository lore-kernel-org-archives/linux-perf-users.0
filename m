Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1813C432BE
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 01:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FCCB610C8
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 01:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhIBBes (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 21:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhIBBer (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 21:34:47 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DACC061575;
        Wed,  1 Sep 2021 18:33:49 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id bn14so256826qvb.12;
        Wed, 01 Sep 2021 18:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=OBRd3M7mqtl/UMuNIfJ5th/5maECeKKKCWieM6ZDbl4=;
        b=iLZyRJ7J8UaAQY3ExzbROyTuA2Z9BP6k4rYYpq2TZuwhnR60BQD0hxyNH2wLW7fRMo
         AHxpBBFgopjLavq8yjEV3J6k3cDNyiZ9jBiwL1smnJKk8Mvek3eGDwtSsNR418Csmfqd
         Q7HBVRx9ogrrFAPdwg6+pdjrqNInnNVJrAZIpMNnFWA2kQk24I/uWksTUj9vvXXqw/DW
         Lqu7xWGXltoTU2BH6IkU2L1IlkQ6EyNTkumrzGlWYrsxexKeX5YCDdJgDcsj0cCy8TuF
         g1V+Lm4luIFZ6s115g9JQU/0hRNwa+6Yii6AIwGgPm4s6LxMgQBX+CSKNKr+j9Tjl2Jn
         a2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=OBRd3M7mqtl/UMuNIfJ5th/5maECeKKKCWieM6ZDbl4=;
        b=L9ZziR84bU7FgeCP1F82JUcovm1thQNQwfICaz7z3g2BbW0QIcZuduQOM+ld3yzV4V
         zWSNiUn8HsQIPL/xpAVjO0C+Z3qOUEqCAW71xOKRVDdwsS9O9hfg3bGJWDDFeb2ocCIs
         kXZgt69pBHzOHP5unh+sUc0J62k1bEOkCtbpGWJZP9SID0eK/AF0/msJiYxdl21TPA73
         W9gs6PKat4YOsTDzC3QXAClhXU3Vs43iL48T9swGZVFeaacxJNM8GMaeUCNyPTHyfcGh
         kXFPAHwQqtBwJ4ETGREFAOsWJzP+6JrXtwhF4erV3s7Q/KbW0MHfwVrtnil6GnUdXOUP
         e5zw==
X-Gm-Message-State: AOAM5315xfGQUxEkiJxdNUtACzxR1ZClUKjYM9V1uJnVKc7wdeDx/uKm
        BIlelXtPlgUhbRvLFYP7OY0=
X-Google-Smtp-Source: ABdhPJyZRmncWfwuNXcHcLV7d8ixfPdy79i6O29Z3TlCwTFWiUgH+dD+SELU9MaNal37Rb3EZblQag==
X-Received: by 2002:a0c:cc8f:: with SMTP id f15mr855868qvl.47.1630546428767;
        Wed, 01 Sep 2021 18:33:48 -0700 (PDT)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id w20sm159079qtj.72.2021.09.01.18.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 18:33:48 -0700 (PDT)
Date:   Wed, 01 Sep 2021 22:33:38 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, rickyman7@gmail.com,
        john.garry@huawei.com, Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH v6 1/2] perf pmu: Add PMU alias support
User-Agent: K-9 Mail for Android
In-Reply-To: <298a4efe-72f3-f99a-3923-939eab44885a@linux.intel.com>
References: <20210901054602.17010-1-yao.jin@linux.intel.com> <20210901054602.17010-2-yao.jin@linux.intel.com> <YS+G5s41RWX0GIqG@kernel.org> <298a4efe-72f3-f99a-3923-939eab44885a@linux.intel.com>
Message-ID: <59B604C2-8E26-4B11-A9E7-F0885058D990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On September 1, 2021 9:58:16 PM GMT-03:00, "Jin, Yao" <yao=2Ejin@linux=2Ei=
ntel=2Ecom> wrote:
>Hi Arnaldo,
>
>On 9/1/2021 9:57 PM, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Sep 01, 2021 at 01:46:01PM +0800, Jin Yao escreveu:
>> <SNIP>
>>=20
>>> +++ b/tools/perf/arch/x86/util/pmu=2Ec
>>=20
>> <SNIP>
>>=20
>>> +static int setup_pmu_alias_list(void)
>>> +{
>>> +	char path[PATH_MAX];
>>> +	DIR *dir;
>>> +	struct dirent *dent;
>>> +	const char *sysfs =3D sysfs__mountpoint();
>>> +	struct perf_pmu_alias_name *pmu;
>>> +	char buf[MAX_PMU_NAME_LEN];
>>> +	FILE *file;
>>> +	int ret =3D 0;
>>> +
>>> +	if (!sysfs)
>>> +		return -1;
>>> +
>>> +	snprintf(path, PATH_MAX,
>>> +		 "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
>>> +
>>> +	dir =3D opendir(path);
>>> +	if (!dir)
>>> +		return -1;
>>> +
>>> +	while ((dent =3D readdir(dir))) {
>>> +		if (!strcmp(dent->d_name, "=2E") ||
>>> +		    !strcmp(dent->d_name, "=2E=2E"))
>>> +			continue;
>>> +
>>> +		snprintf(path, PATH_MAX,
>>> +			 TEMPLATE_ALIAS, sysfs, dent->d_name);
>>> +
>>> +		if (!file_available(path))
>>> +			continue;
>>> +
>>> +		file =3D fopen(path, "r");
>>> +		if (!file)
>>> +			continue;
>>> +
>>> +		if (!fgets(buf, sizeof(buf), file)) {
>>> +			fclose(file);
>>> +			continue;
>>> +		}
>>> +
>>> +		fclose(file);
>>> +
>>> +		pmu =3D zalloc(sizeof(*pmu));
>>> +		if (!pmu) {
>>> +			ret =3D -ENOMEM;
>>> +			break;
>>> +		}
>>> +
>>> +		/* Remove the last '\n' */
>>> +		buf[strlen(buf) - 1] =3D 0;
>>> +
>>> +		pmu->alias =3D strdup(buf);
>>> +		if (!pmu->alias)
>>> +			goto mem_err;
>>=20
>> This isn't returning -ENOMEM like when zalloc() fails above=2E Also you=
're
>> mixing 'return -1' with 'return -ENOMEM', please be consistent=2E Pleas=
e
>> find some -E errno for the !sysfs case, perhaps -ENODEV?
>>=20
>
>For opendir() error, can we just return -errno?
>
>dir =3D opendir(path);
>if (!dir)
>	return -errno;

Yeah

>
>>> +
>>> +		pmu->name =3D strdup(dent->d_name);
>>> +		if (!pmu->name)
>>> +			goto mem_err;
>>> +
>>> +		list_add_tail(&pmu->list, &pmu_alias_name_list);
>>> +		continue;
>>=20
>>=20
>> Don't we have a 'struct pmu' constructor/destructor pair? I=2Ee=2E inst=
ead
>> of doing all this in an open coded way as above, why not have:
>>=20
>> void pmu__delete(struct pmu *pmu)
>> {
>> 	if (!pmu)
>> 		return;
>>=20
>> 	zfree(&pmu->name);
>> 	zfree(&pmu->alias);
>> 	free(pmu);
>> }
>>=20
>> struct pmu *pmu__new(const char *name, const char *alias)
>> {
>> 	struct pmu *pmu =3D zalloc(sizeof(*pmu));
>>=20
>> 	if (pmu) {
>> 		pmu->name =3D strdup(name);
>> 		if (!pmu->name)
>> 			goto out_delete;
>>=20
>> 		pmu->alias =3D strdup(alias);
>> 		if (!pmu->alias)
>> 			goto out_delete;
>> 	}
>>=20
>> 	return pmu;
>> out_err:
>> 	pmu__delete(pmu);
>> 	return NULL;
>> }
>>=20
>> 	And then just:
>>=20
>> 	pmu =3D pmu__new(dent->d_name, buf);
>> 	if (!pmu)
>> 		goto out_closedir;
>>=20
>> 	list_add_tail(&pmu->list, &pmu_alias_name_list);
>>=20
>> And then you don't need the 'continue', as this is the end of the loop
>> block=2E
>> 	=09
>> That 'ret' probably should start with -ENOMEM and you end the function
>> with:
>>=20
>> 	ret =3D 0;
>> out_closedir:
>> 	closedir(dir);
>> 	return ret;
>> }
>
>Yes, using 'struct pmu' constructor/destructor is absolutely a good desig=
n=2E
>
>I will follow this approach=2E


I've read the other message you sent, so do the constructor/destructor for=
 the right struct, that long named one=2E

- Arnaldo 
