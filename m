Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B315CB5
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53173E4;
	Fri,  6 Oct 2023 01:10:02 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S21Jb2RL7z6K5yx;
	Fri,  6 Oct 2023 16:08:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 6 Oct
 2023 09:09:59 +0100
Date: Fri, 6 Oct 2023 09:09:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Kuan-Wei Chiu <visitorckw@gmail.com>, <yangyicong@hisilicon.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Ian
 Rogers" <irogers@google.com>
Subject: Re: [PATCH] perf hisi-ptt: Fix memory leak in lseek failure
 handling
Message-ID: <20231006090959.00005787@Huawei.com>
In-Reply-To: <CAM9d7ciJZsCaVo6m_VtJ=QKNGAtBkAncidQjHzwexd3H8+3Usw@mail.gmail.com>
References: <20230930072719.1267784-1-visitorckw@gmail.com>
	<CAM9d7ciJZsCaVo6m_VtJ=QKNGAtBkAncidQjHzwexd3H8+3Usw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2 Oct 2023 21:48:14 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> Hello,
>=20
> On Sat, Sep 30, 2023 at 12:27=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.=
com> wrote:
> >
> > In the previous code, there was a memory leak issue where the previously
> > allocated memory was not freed upon a failed lseek operation. This patch
> > addresses the problem by releasing the old memory before returning -err=
no
> > in case of a lseek failure. This ensures that memory is properly managed
> > and avoids potential memory leaks.
> >
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com> =20
>=20
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>=20
FYI, Ian Rogers has a series with a similar fix that goes a little further
and drops the assignment of data_offset seen just at the top of the context
below as it is unused.

https://lore.kernel.org/all/20231005230851.3666908-5-irogers@google.com/

I haven't replied to this yet as want to check some related handling
with one of my China based colleagues and it's a festival this week.

One of us will get back on this next week,

Jonathan

> Thanks,
> Namhyung
>=20
>=20
> > ---
> >  tools/perf/util/hisi-ptt.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> > index 45b614bb73bf..43bd1ca62d58 100644
> > --- a/tools/perf/util/hisi-ptt.c
> > +++ b/tools/perf/util/hisi-ptt.c
> > @@ -108,8 +108,10 @@ static int hisi_ptt_process_auxtrace_event(struct =
perf_session *session,
> >                 data_offset =3D 0;
> >         } else {
> >                 data_offset =3D lseek(fd, 0, SEEK_CUR);
> > -               if (data_offset =3D=3D -1)
> > +               if (data_offset =3D=3D -1) {
> > +                       free(data);
> >                         return -errno;
> > +               }
> >         }
> >
> >         err =3D readn(fd, data, size);
> > --
> > 2.25.1
> > =20
>=20

