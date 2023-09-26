Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC52905
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 22:37:25 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EDF23103
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 15:37:24 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-79faf4210b2so242932139f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 15:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695767843; x=1696372643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GH96LiNc6wK6MXQb714sEPdA/4C5gNr2ow4kqLj+00=;
        b=Zu2QhkLBlg7me6eGl4m8K2kgdpxMg2Pi4f+eBktonXiE6ZlxjES9Q47U6e6WSEivX0
         WkrSfchUWta3behSvk4XOFmOFJIQSOrjBdXiaP2TDTHLlyIb/sLQDswEtQvbBRcxfzcz
         LFgboKNKNdriBLey5sQlG9lfQbPyKoDvnJ9BDdBX5+WQ4YGvCe/qPwOhDxg5CxLFhlrM
         2Jn4c48uQ/vtCCr7Zrre6CbDtr9MCR4K9BAkwSrVnHoKBVA5ii7hFSBEiKNtMHB/gwES
         oya5W2mOwGjtkIFSFlN/cjkXxJ/3aNvLciuHvgkvqXj1GCAUSAt9GxzviJa9vSxuiQqX
         Y5NQ==
X-Gm-Message-State: AOJu0Yy21yGw0GdtxcCUBXzMnVypuVWTp6tnS453ei2jdGdGGObWeWkC
	skz0ZgGd7Ep/CR8NSlmCFcI5hkwE3K/Zu+rA8Lyk7auE
X-Google-Smtp-Source: AGHT+IEYuHig40h2Sk4Ta/ViVmjYwQksQIPo0D2f+Okq+2a8j2jNjoxOkvEhnfwwp5/anaD4GvcRmv41tCiiti4v4oQ=
X-Received: by 2002:a5d:9251:0:b0:79f:e9ac:f60a with SMTP id
 e17-20020a5d9251000000b0079fe9acf60amr153708iol.20.1695767843632; Tue, 26 Sep
 2023 15:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907165933.36442-1-atrajeev@linux.vnet.ibm.com>
 <1F3D650F-91B5-4570-85D2-A925320BE7AE@linux.ibm.com> <298307AE-8AB5-40B6-A9CC-C1DBE720450C@linux.vnet.ibm.com>
 <2C5606DF-4532-4263-9482-50D5668C09AF@linux.vnet.ibm.com> <CA+JHD90aQ5OM3PLrrt2nnBDL1b6-Hx7EsRjpnzawzYY3VSYi3Q@mail.gmail.com>
In-Reply-To: <CA+JHD90aQ5OM3PLrrt2nnBDL1b6-Hx7EsRjpnzawzYY3VSYi3Q@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 26 Sep 2023 15:37:12 -0700
Message-ID: <CAM9d7cj=h=8omHwerjXPaWJbNFOpaiogjw8gsTdvwS7mTschsg@mail.gmail.com>
Subject: Re: [PATCH V2] perf test: Fix parse-events tests to skip parametrized events
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Sachin Sant <sachinp@linux.ibm.com>, 
	Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Disha Goel <disgoel@linux.vnet.ibm.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Mon, Sep 25, 2023 at 10:37=E2=80=AFAM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Wed, Sep 13, 2023, 7:40 AM Athira Rajeev <atrajeev@linux.vnet.ibm.com>=
 wrote:
>>
>>
>>
>> > On 08-Sep-2023, at 7:48 PM, Athira Rajeev <atrajeev@linux.vnet.ibm.com=
> wrote:
>> >
>> >
>> >
>> >> On 08-Sep-2023, at 11:04 AM, Sachin Sant <sachinp@linux.ibm.com> wrot=
e:
>> >>
>> >>
>> >>
>> >>> On 07-Sep-2023, at 10:29 PM, Athira Rajeev <atrajeev@linux.vnet.ibm.=
com> wrote:
>> >>>
>> >>> Testcase "Parsing of all PMU events from sysfs" parse events for
>> >>> all PMUs, and not just cpu. In case of powerpc, the PowerVM
>> >>> environment supports events from hv_24x7 and hv_gpci PMU which
>> >>> is of example format like below:
>> >>>
>> >>> - hv_24x7/CPM_ADJUNCT_INST,domain=3D?,core=3D?/
>> >>> - hv_gpci/event,partition_id=3D?/
>> >>>
>> >>> The value for "?" needs to be filled in depending on system
>> >>> configuration. It is better to skip these parametrized events
>> >>> in this test as it is done in:
>> >>> 'commit b50d691e50e6 ("perf test: Fix "all PMU test" to skip
>> >>> parametrized events")' which handled a simialr instance with
>> >>> "all PMU test".
>> >>>
>> >>> Fix parse-events test to skip parametrized events since
>> >>> it needs proper setup of the parameters.
>> >>>
>> >>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> >>> ---
>> >>> Changelog:
>> >>> v1 -> v2:
>> >>> Addressed review comments from Ian. Updated size of
>> >>> pmu event name variable and changed bool name which is
>> >>> used to skip the test.
>> >>>
>> >>
>> >> The patch fixes the reported issue.
>> >>
>> >> 6.2: Parsing of all PMU events from sysfs                          : =
Ok
>> >> 6.3: Parsing of given PMU events from sysfs                        : =
Ok
>> >>
>> >> Tested-by: Sachin Sant <sachinp@linux.ibm.com>
>> >>
>> >> - Sachin
>> >
>> > Hi Sachin, Ian
>> >
>> > Thanks for testing the patch
>>
>> Hi Arnaldo
>>
>> Can you please check and pull this if it looks good to go .
>
>
> Namhyung, can you please take a look?

Yep sure.  I think it needs to close the file when getline() fails.

Athira, can you please send v3 with that?

Thanks,
Namhyung
