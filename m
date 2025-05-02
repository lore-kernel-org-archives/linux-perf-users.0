Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3945170A2B;
	Fri,  2 May 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195340; cv=none; b=FptQGHcp2p5TY+XX3t7d0rhaHhDUaTmaTOmQUKOnD0SeFiIwiqbjVPNMHMbZE/e5p1Yk1qpt28VRwP5kVaxjnfrKhObTFT6niWFZu79Gtd5+8SBIT0s2d0vEtPfXq4qf5fe33E19msUxK7mOVOBPo3+ARpbG+2blpzmLTFpnVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195340; c=relaxed/simple;
	bh=RIfl0KP/59TNe/iVyeBl8pr/SbLz3bMSndMSKx1wQno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u9NA6TNsm0ixYDwbJwcwYqE3ANgWq3pvxno/aP8LHHx/Oen5lL5aiwYILNL3rDof4IKop37ZtXtXem1HVcT/0BUZSsBtlMqomyITq4zRCJOLYb3mR/VQ3gp8UPpM7wU05dzdA4wWd805u+88Z9HQn6tFG5wzJL8SpE1aOnkJ9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=M0Rm0Utu; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="M0Rm0Utu"
Received: from localhost (ip-109-42-178-232.web.vodafone.de [109.42.178.232])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 542ECN3D018135
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 2 May 2025 16:12:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1746195150; bh=RIfl0KP/59TNe/iVyeBl8pr/SbLz3bMSndMSKx1wQno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=M0Rm0Utu/TA2y8kZiW08P3Cgiuaax8JfSfxIwXqqooqPhwOr8Bpi/Jb3TLK7pgqfm
	 KbQQiTcYThGkvg6sL/020Hd0jaVImhPZpGJISGUu0KVPALipjhyGr1ajO3V3h4L2xW
	 dc5lu0Qx5QjKk/I9i5VwVAlb/nnSWbZmHoCcezSQ=
From: Dirk Gouders <dirk@gouders.net>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland
 <mark.rutland@arm.com>,
        Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang
 <kan.liang@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus
 Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr
 Bueso <dave@stgolabs.net>,
        =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>,
        John
 Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
        James
 Clark <james.clark@linaro.org>,
        Mike Leach <mike.leach@linaro.org>, Leo
 Yan <leo.yan@linux.dev>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Nathan Chancellor
 <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt
 <justinstitt@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Al Viro
 <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>,
        Ben Gainey
 <ben.gainey@arm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol
 Jain <kjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Eder
 Zulian <ezulian@redhat.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>,
        Brian Geffon <bgeffon@google.com>,
        Ravi Bangoria
 <ravi.bangoria@amd.com>,
        Howard Chu <howardchu95@gmail.com>,
        Charlie
 Jenkins <charlie@rivosinc.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jann Horn
 <jannh@google.com>, Masahiro Yamada <masahiroy@kernel.org>,
        Arnd
 Bergmann <arnd@arndb.de>, Yang Jihong <yangjihong@bytedance.com>,
        Dmitry
 Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
        Graham
 Woodward <graham.woodward@arm.com>,
        Ilkka Koskinen
 <ilkka@os.amperecomputing.com>,
        Anshuman Khandual
 <anshuman.khandual@arm.com>,
        Zhongqiu Han <quic_zhonhan@quicinc.com>, Hao Ge <gehao@kylinos.cn>,
        Tengda Wu <wutengda@huaweicloud.com>,
        Gabriele Monaco <gmonaco@redhat.com>,
        Chun-Tse Shao <ctshao@google.com>, Casey Chen <cachen@purestorage.com>,
        "Dr. David Alan Gilbert"
 <linux@treblig.org>,
        Li Huafei <lihuafei1@huawei.com>,
        "Steinar H.
 Gunderson" <sesse@google.com>,
        Levi Yun <yeoreum.yun@arm.com>, Weilin
 Wang <weilin.wang@intel.com>,
        Thomas Falcon <thomas.falcon@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Andrew Kreimer
 <algonell@gmail.com>,
        Krzysztof =?utf-8?Q?=C5=81opatowski?=
 <krzysztof.m.lopatowski@gmail.com>,
        Christophe Leroy
 <christophe.leroy@csgroup.eu>,
        Jean-Philippe Romain
 <jean-philippe.romain@foss.st.com>,
        Junhao He <hejunhao3@huawei.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Xu Yang
 <xu.yang_2@nxp.com>,
        Steve Clevenger
 <scclevenger@os.amperecomputing.com>,
        Zixian Cai <fzczx123@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Yujie Liu
 <yujie.liu@intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 04/47] perf bench: Silence -Wshorten-64-to-32 warnings
In-Reply-To: <20250502130635.0eabb190@pumpkin> (David Laight's message of
	"Fri, 2 May 2025 13:06:35 +0100")
References: <20250430175036.184610-1-irogers@google.com>
	<20250430175036.184610-5-irogers@google.com>
	<gho6wdh00l.fsf@gouders.net>
	<CAP-5=fUdpa40MDNu0aDBO7o8H3YMe-cYsg-YfqUUZUY4M4XLeA@mail.gmail.com>
	<ghecx9guoj.fsf@gouders.net>
	<CAP-5=fXJpD_f6dUqroVpqe-OX5kyOPc1zpbyOZoQtqvQWBGr=Q@mail.gmail.com>
	<gha57xgs8b.fsf@gouders.net> <20250502130635.0eabb190@pumpkin>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 02 May 2025 16:12:17 +0200
Message-ID: <ghfrhnaypq.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Laight <david.laight.linux@gmail.com> writes:

> On Thu, 01 May 2025 01:11:16 +0200
> Dirk Gouders <dirk@gouders.net> wrote:
>
>> Ian Rogers <irogers@google.com> writes:
>>=20
>> > On Wed, Apr 30, 2025 at 3:19=E2=80=AFPM Dirk Gouders <dirk@gouders.net=
> wrote:=20=20
>> >>
>> >> Ian Rogers <irogers@google.com> writes:
>> >>=20=20
>> >> > On Wed, Apr 30, 2025 at 1:23=E2=80=AFPM Dirk Gouders <dirk@gouders.=
net> wrote:=20=20
>> >> >>
>> >> >> Hi Ian,
>> >> >>
>> >> >> considering so many eyes looking at this, I am probably wrong.
>> >> >>
>> >> >> So, this is only a "gauge reply" to see if it's worth I really read
>> >> >> through all the commits ;-)
>> >> >>
>> >> >> Ian Rogers <irogers@google.com> writes:
>> >> >>
>> >> >> [SNIP]
>> >> >>=20=20
>> >> >> > diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sc=
hed-pipe.c
>> >> >> > index 70139036d68f..b847213fd616 100644
>> >> >> > --- a/tools/perf/bench/sched-pipe.c
>> >> >> > +++ b/tools/perf/bench/sched-pipe.c
>> >> >> > @@ -102,7 +102,8 @@ static const char * const bench_sched_pipe_u=
sage[] =3D {
>> >> >> >  static int enter_cgroup(int nr)
>> >> >> >  {
>> >> >> >       char buf[32];
>> >> >> > -     int fd, len, ret;
>> >> >> > +     int fd;
>> >> >> > +     ssize_t ret, len;
>> >> >> >       int saved_errno;
>> >> >> >       struct cgroup *cgrp;
>> >> >> >       pid_t pid;
>> >> >> > @@ -118,7 +119,7 @@ static int enter_cgroup(int nr)
>> >> >> >       cgrp =3D cgrps[nr];
>> >> >> >
>> >> >> >       if (threaded)
>> >> >> > -             pid =3D syscall(__NR_gettid);
>> >> >> > +             pid =3D (pid_t)syscall(__NR_gettid);
>> >> >> >       else
>> >> >> >               pid =3D getpid();
>> >> >> >
>> >> >> > @@ -172,23 +173,25 @@ static void exit_cgroup(int nr)
>> >> >> >
>> >> >> >  static inline int read_pipe(struct thread_data *td)
>> >> >> >  {
>> >> >> > -     int ret, m;
>> >> >> > +     ssize_t ret;
>> >> >> > +     int m;
>> >> >> >  retry:
>> >> >> >       if (nonblocking) {
>> >> >> >               ret =3D epoll_wait(td->epoll_fd, &td->epoll_ev, 1,=
 -1);=20=20
>> >> >>
>> >> >> The epoll_wait(), I know of, returns an int and not ssize_t.
>> >> >>
>> >> >> That shouldn't show up, because it doesn't cause real problems...=
=20=20
>> >> >
>> >> > So the function is read_pipe so it should probably return a ssize_t=
. I
>> >> > stopped short of that but made ret a ssize_t to silence the truncat=
ion
>> >> > warning on the read call. Assigning smaller to bigger is of course =
not
>> >> > an issue for epoll_wait.=20=20
>> >>
>> >> Oh yes, I missed that ret is also used for the result of read().
>> >>
>> >> Some lines down there is also a combination of
>> >>
>> >> ret =3D enter_cgroup() (which is int)
>> >>
>> >> and
>> >>
>> >> ret =3D write()
>> >>
>> >>
>> >> Just confusing but yes, because ret is also used for read() and write=
()
>> >> in those cases it should be ssize_t.
>> >>
>> >> I'm sorry for the noise.=20=20
>> >
>> > No worries, I'm appreciative of the eyes. I suspect we'll only pick up
>> > the first patches in this series to fix what is a bug on ARM. I think
>> > I'm responsible for too much noise here ;-)=20=20
>>=20
>> A final thought (in case this patch will also be picked):
>>=20
>> Why not, in case of read_pipe() and worker_thread() just cast
>> read() and write() to int?  Both get counts of sizeof(int) and
>> it would clearly show: we know the result fits into an int.
>
> This is an obvious case of the entire insanity of these changes.

You mean, because there is still the -1 case where the sign-lost can
happen?

I guess your reply is in combination with your replies to another thread
to this subject.  As far as I understood, Ian also has problems with
full understanding and I wonder if it helps to talk about a real
example.  As far as I understood you say that code like this
(from tools/perf/bench/sched-pipe.c) is simply wrong:

static inline int read_pipe(struct thread_data *td)
{
	int ret, m;
retry:
	if (nonblocking) {
		ret =3D epoll_wait(td->epoll_fd, &td->epoll_ev, 1, -1);
		if (ret < 0)
			return ret;
	}
	ret =3D read(td->pipe_read, &m, sizeof(int));
	if (nonblocking && ret < 0 && errno =3D=3D EWOULDBLOCK)
		goto retry;
	return ret;
}

And from your reply I understand that casting the read() explicitely to
int is insane.  And now, I wonder what you would suggest -- honestly, I
am expecting to learn something, here.

Best regards,

Dirk
