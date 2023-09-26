Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF84B201
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 21:29:03 +0000 (UTC)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D53A278
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 14:29:02 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-414ba610766so130241cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695763742; x=1696368542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3abD7iQzIMI/zplhS+FMTtuLo16s/fzBh1urRcorsU0=;
        b=4Z4Imk+wWDxLBUYRBttDuyCip5FoMBN5rV5uR4NK8vHjxAm96ecTas3k5vFPNfk2Bf
         5xhv0qAe6qOyxyCR9MhnQev51ZRnLdjEVfP7q/RnDFAnDrSH34rkZEdTpb6K/ypC2umy
         XvLST/W4yBXP/K6il1TEXNx+TZlzbT/SsyyTvuE9I0bA/vTtFa3spl8DXU83dN5Tjxl6
         yhg46g5rXs2tpi/YqdUh2T01hFR182OiKp6YfA1hNqsiZVGtxOaTJt+kZ4z8A/4HCtyU
         u+wlGnmGE0wnHwX5n2FsIs5m+5tjWRb+dO5mkX7u0Qe/0z3GNrn+aiUIoq+1L4ceB7u9
         qveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763742; x=1696368542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3abD7iQzIMI/zplhS+FMTtuLo16s/fzBh1urRcorsU0=;
        b=d60Nf8sCax/26ZKGBuwD7SZEww5GiUiC/ztb/s+xHG7P0Zyq3eeW96+cZPEwKk5PCt
         5zOG23B7ElIkm09y7XifLBugWDKLc1R4irxR6vdm7ItyPKlMRJx84wsEhloPLuLTTe8Y
         MJ1gzzakU3jrkH/qpB6XCqXu6+LyWw1prPxVV68xRaJnDGIO+e0v/UyW0etO8TwI7XSJ
         8ImaHlnjWNBly3Wv4jZ3XJaIhKqpjbzUYJ2/WwyUZah0kqJTb/kZUKXoLIb3EeY8Arff
         ln6tXrJTuBMhYGeQ4gZEsaRnM/0ZM4stLr0VV3SfYCDgorMTdNf16FD5LAPCbidDWgtT
         3GqQ==
X-Gm-Message-State: AOJu0YzwdhZATFAVClR4siJazIlGQLO6QZ/yrK7bl27DxZCkLw2782Nq
	wYDAN+DYQh69603hRyq3GMfpQYIxHQeaT3IsYqMvy8WryGxuZk48HqNLPpQi
X-Google-Smtp-Source: AGHT+IFvdD+qVFf+fOCdWmSIUAvxNfOQqqfxPLNzzFor4BTk5dc7YMfCYSBrsbAoAETPqg+c0mX+puL8M6Wvi71F8h0=
X-Received: by 2002:ac8:5b44:0:b0:403:eeb9:a76 with SMTP id
 n4-20020ac85b44000000b00403eeb90a76mr355357qtw.17.1695763741863; Tue, 26 Sep
 2023 14:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PAWPR04MB97658DD9546C6D0A141C0766EAC3A@PAWPR04MB9765.eurprd04.prod.outlook.com>
In-Reply-To: <PAWPR04MB97658DD9546C6D0A141C0766EAC3A@PAWPR04MB9765.eurprd04.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 26 Sep 2023 14:28:50 -0700
Message-ID: <CAP-5=fVPVodcSkOHnJOrgkUO1QOnNTcsPMsfeEKvzjTvqA2K+w@mail.gmail.com>
Subject: Re: [6.5.4] perf: bison min. requirements
To: Pierre Cheynier <p.cheynier@criteo.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 1:21=E2=80=AFAM Pierre Cheynier <p.cheynier@criteo.=
com> wrote:
>
> Dear list,
> At compiling 6.5.4 it seemed to me that this specific patch [1] added an =
implicit dependency to bison >=3D 3.7.4, due to usage of YYNOMEM.
> Shouldn't this be part of Documentation/process/changes.rst?
>
> [1] https://www.spinics.net/lists/linux-perf-users/msg30885.html "perf pa=
rse-events: Separate YYABORT and YYNOMEM cases"
>
> Sorry for the noise, and thanks for inputs if ever I'm totally wrong here=
.

We have a workaround to #define YYNOMEM to YYABORT when Bison is
less-than 3.8.1:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/Build?h=3Dperf-tools-next#n323
Perhaps you can help debug why this build logic isn't working for you?

Thanks,
Ian

> --
> Pierre
