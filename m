Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72216C00140
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Aug 2022 07:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbiHOHPE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Aug 2022 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiHOHOn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Aug 2022 03:14:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEC81CB00
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Aug 2022 00:14:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gb36so12085607ejc.10
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Aug 2022 00:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc;
        bh=fP3+e4Xpzy8lqTrEpmhkpBj83B7QmOa6cMB7d+YHYIY=;
        b=V6P6zicK9gPSx4ylIKaaWQvg6dT7w8NeqfeBiGk2AqYftWjI/aCRYI9UkZp0fYrop3
         KXcRWnny/hBwFnGC0eeaN+fgcOnexTe5y0SYIa0e4Ci3Ed9fNZscEjhk5MSyJDObEeob
         eik/Aw6lJBthUe8gyHVvnDZuUlOx8rHuUQV+N9GMDWiNxrrja3Q+dHqRujYVvMy78Doo
         Vqo14Q7LI9TTAMHpVymEZPyF4Vp7h/oaDigXhDTDO3DVVBECCG+g0n0KDG+dRm/C8jbz
         YmloTmY/Iqf4LRuLGq62Gvw+SLLAbOFV5RGnnZ474qfuS3U6Xh7HG28rH6aJHB5lsCeQ
         tQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc;
        bh=fP3+e4Xpzy8lqTrEpmhkpBj83B7QmOa6cMB7d+YHYIY=;
        b=GJIdXVneTjUPEipybJThS8hT2swILgxg6X1Hkk5JldTa41TGzrY15vzY5t/Px5abCv
         hQZlwnEPqPvJsg050/m7Gh1WQXDwIuT5IbQUy2/hhtN/YAsqKNKDZaEwxLvBuk5KGQc4
         WSlJYlFoN/cctZ2I8SGmDt04Et4NIQTAcp98GY/n3mQXfGOrXt49zN5kn9G+kr+t5MSs
         myL9whZYAFgtWd+SCFJ4L2wAzAKZg3G2fQR4wCoLPDpGolXOuMxCVkd9y5s4yAREGI9y
         Vw+qBEeY5jCKH9J1sGBhwB15hRpU0UkV1KMiZ9oWwgSUibClKflLsIWm8h27EMY99U4c
         AAdQ==
X-Gm-Message-State: ACgBeo243Vk7L5otJsatJFmfrmJCMMEbqCThpqwzwbzKDOTakKYT0vqo
        vr6mUe54lkafgeF5yYjGMVGm2Mya4X/zmA==
X-Google-Smtp-Source: AA6agR7xr76RZIaTQlCBcB7yo0gUmdipyCOZ7e7lowLvahYSfnGYBefw+5pn4TGomCYxQNFWZBr0bA==
X-Received: by 2002:a17:907:60c7:b0:731:17e4:7fcc with SMTP id hv7-20020a17090760c700b0073117e47fccmr9625801ejc.73.1660547662679;
        Mon, 15 Aug 2022 00:14:22 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id el13-20020a056402360d00b00443d657d8a4sm774573edb.61.2022.08.15.00.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 00:14:22 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 15 Aug 2022 09:14:21 +0200
To:     Hongtao Yu <hoy@fb.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Cannot print 'uregs' field with perf script -F uregs
Message-ID: <YvnyTc5q91d2RpQi@krava>
References: <MW3PR15MB3868A1461BB93AC91C242B0CCF689@MW3PR15MB3868.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW3PR15MB3868A1461BB93AC91C242B0CCF689@MW3PR15MB3868.namprd15.prod.outlook.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 15, 2022 at 04:22:57AM +0000, Hongtao Yu wrote:
> Hi,
>  
> I was seeing an issue with “perf script -F uregs”: 
>  
> Samples for 'dummy:HG' event do not have UREGS attribute set. Cannot print 'uregs' field.
>  
> This seems to only happen to a perf.data resulted from a system-wide monitoring, e.g “perf record -a”. Per-process monitoring works fine. By search up online I see a thread that could be relevant:   https://lore.kernel.org/all/YVNq9av%2F3Lwmom4T@krava/
>  
> Can someone please shed a light whether this is an issue with perf, or something wrong with my perf.data?
>  
>  
> Thanks,
> Hongtao
>  
>  


hum, I thought we already fixed this.. would fix below work for you?

thanks,
jirka


---
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 13580a9c50b8..30c9cbdee98d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -451,6 +451,9 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 	allow_user_set = perf_header__has_feat(&session->header,
 					       HEADER_AUXTRACE);
 
+	if (evsel__is_dummy_event(evsel))
+		allow_user_set = true;
+
 	if (PRINT_FIELD(TRACE) &&
 	    !perf_session__has_traces(session, "record -R"))
 		return -EINVAL;
@@ -517,7 +520,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 
 	if (PRINT_FIELD(UREGS) &&
-	    evsel__check_stype(evsel, PERF_SAMPLE_REGS_USER, "UREGS", PERF_OUTPUT_UREGS))
+	    evsel__do_check_stype(evsel, PERF_SAMPLE_REGS_USER, "UREGS", PERF_OUTPUT_UREGS, allow_user_set))
 		return -EINVAL;
 
 	if (PRINT_FIELD(PHYS_ADDR) &&
