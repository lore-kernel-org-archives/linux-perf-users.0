Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2212FC77B75
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 May 2023 02:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjECCzg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 22:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECCzf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 22:55:35 -0400
X-Greylist: delayed 1669 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 19:55:34 PDT
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A581BDF
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 19:55:34 -0700 (PDT)
Received: from pps.filterd (m0119691.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342LOuQr037211
        for <linux-perf-users@vger.kernel.org>; Tue, 2 May 2023 22:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=20180315;
 bh=l+Bn2nkMpuhSmnNKAbWRfREFiQ9EAb033dHO+OxbTcA=;
 b=aRXSO8suZ27stxath8gkhd5iNXkgR8SiqAgBhADw6KlQ6rEsAm9I7Qd+K4fTZFujTOZl
 5CLcCsLTMDhjuVVJ0Ri1sc5tStvycQbrUoXe1f4S+1ANbkqi3J4VJnp+Gu2Y7cHcXJ4V
 amofC/9GCXzk6uliOUcJco97Q8oHyPWI5uDCJIV+aYU0zbRu8rOb/+SQ3X5LzGbxLCHI
 m/kCyraW+mvSG6VbwK4JiaOOLi3+wnNzg7gRdBn7DZ1vkz58H829ACJqcCCn7oBYATLa
 B/MfMIpF4PfVS5um1iy56FxSNmeQm93tX5dvDw/k7NcDRTszZfwW/UJKEUQrWiu/iBjZ Pg== 
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 3qbads2p66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 22:27:44 -0400
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso1471488276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 19:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683080864; x=1685672864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+Bn2nkMpuhSmnNKAbWRfREFiQ9EAb033dHO+OxbTcA=;
        b=g1j90QXXzWc7p5Yuz4HBbV2PD+YlMuXRGBGH9jZnTNuioIhCKWH/rr585KGB1tb1yh
         lBj9bhWhAApf4oowO12xe5A7MXMy/vdw5r1AhQ2zmT9rEBWd6YDUo9gxVos+iaQu1GRA
         Byp1h89mHW973GOk4qqOFZPUV1/L8NxPTkB+QPAPfgQtPNrF3ocfYr7PwIMmr828JpNx
         lkbkJq9i8pXr6/1yYCN9JVy3oCuCi3hKENHefyMahlRfwgfzJ8P6SiQUE6pIpXqdVrVE
         /uzDagVs+pskZgRjnklw0A4cjXm3Z1zXHm5eb//9MaQvn3nyLXaxkCPdRmQuTSyck1T+
         ndTA==
X-Gm-Message-State: AC+VfDzFYi4t33t7dFHgMoadE51RsmQUYizN/fIcr7PMfkCZpx3la0NN
        5Bu8n3i4Cwrjx9cxsXf92h+EsDmoGkweuyp9mc483lMYZ4XwMCSkuM6UHiuNJmtBa8rxp9sLonW
        C+xR4f5EedQ2KTQY+7t2xcG3O5Y+1TYGY9C6o5jv8SDkA
X-Received: by 2002:a25:1589:0:b0:b9e:6d19:306a with SMTP id 131-20020a251589000000b00b9e6d19306amr720919ybv.16.1683080863729;
        Tue, 02 May 2023 19:27:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4nSdJ4vtc+2UclyuNh0+gY80V3U5o6WdNawveEVX91KYB4qQv+i0K+0gnFobH2ZIU67GOgWsA1q0uY80FI4TU=
X-Received: by 2002:a25:1589:0:b0:b9e:6d19:306a with SMTP id
 131-20020a251589000000b00b9e6d19306amr720903ybv.16.1683080863438; Tue, 02 May
 2023 19:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230502203135.24794-1-jinli.xiao@nyu.edu> <CAP-5=fV-RZGwcM8+dMCsqwK_1aFERrvQ1sLJfUCA+kBFMEdoDw@mail.gmail.com>
In-Reply-To: <CAP-5=fV-RZGwcM8+dMCsqwK_1aFERrvQ1sLJfUCA+kBFMEdoDw@mail.gmail.com>
From:   Jinli Xiao <jinli.xiao@nyu.edu>
Date:   Tue, 2 May 2023 22:27:32 -0400
Message-ID: <CAExMFzgmcQqnVSBj9+YVr2UAkUg8CHdpLjQJF6CuOaWdcMbqDQ@mail.gmail.com>
Subject: Re: [PATCH] perf python: Set error messages on call failure
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: DtMgfnIokxVfKBZ8wrR3BD8tHrHjImb7
X-Proofpoint-GUID: DtMgfnIokxVfKBZ8wrR3BD8tHrHjImb7
X-Orig-IP: 209.85.219.198
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030019
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Thanks for the prompt response!

On Tue, May 2, 2023 at 4:37=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Nice! Would it be possible to test this? We could do a shell test

All my changes in this patch is just setting the error message that
can be interpreted by Python just before the bindings return.

I am not sure about shell test, but I can do something like

[root@nyu-lexis linux]# export PYTHONPATH=3D~jinli/linux/tools/perf/python/
[root@nyu-lexis linux]# python3
Python 3.11.2 (main, Feb  8 2023, 00:00:00) [GCC 12.2.1 20221121 (Red
Hat 12.2.1-4)] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import perf
>>> thread_map =3D perf.thread_map(9999)   # a non-existent pid in /proc
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
FileNotFoundError: [Errno 2] No such file or directory

whereas the original output is

>>> thread_map =3D perf.thread_map(9999)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
SystemError: <class 'perf.thread_map'> returned NULL without setting
an exception

Upon testing I did find some of the changes unnecessary. I will submit
a new patch to this.

This is my first time contributing so please let me know if I did
anything wrong :)

Best wishes,
Jinli
