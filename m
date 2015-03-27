From: Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH] perf tui: Annotate entries in callchains
Date: Fri, 27 Mar 2015 16:05:03 -0700
Message-ID: <CABPqkBQ0gVCqPVC2BCSLFLrXmeNnP-yoo7sAfxJyZf8qp6vCiw@mail.gmail.com>
References: <20150319225858.GA16485@kernel.org>
	<CABPqkBRoG4pinYO+FGQVeLa3hQEFk4CjsK0KPFhSKfNr5Ju1=g@mail.gmail.com>
	<CA+JHD93s2VkkdJMKZOGa6fPwEd43C8Ow80CU0b=bwTV=_8zjhw@mail.gmail.com>
	<CABPqkBQkUKkq87=o-XPYyowmYZ4=HWMtB7eYQA4YHsUQs+Kf4w@mail.gmail.com>
	<20150320203922.GO16485@kernel.org>
	<20150320210709.GQ16485@kernel.org>
	<CABPqkBRjHMOzNL=vWqzTUNA_8FidDk=THBErj4c6Tj=6Yw+0hg@mail.gmail.com>
	<20150323002708.GB2782@sejong>
	<CABPqkBRee=X_UumuZfW_9d50f1gjFj4NG_rqchityfYjGQvWXw@mail.gmail.com>
	<3FAA059E-DC0F-4290-BDB5-AE2950D1E1CA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3FAA059E-DC0F-4290-BDB5-AE2950D1E1CA@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 23, 2015 at 9:56 AM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
> Le 23 mars 2015 13:49:24 GMT-03:00, Stephane Eranian <eranian@google.=
com> a =C3=A9crit :
>>On Sun, Mar 22, 2015 at 5:27 PM, Namhyung Kim <namhyung@kernel.org>
>>wrote:().
>>>
>>> Did you play with acme/perf/core not tip/perf/core?  I got same
>>> problem but then I realize it's not the Arnaldo's tree.  When I
>>> changed to acme/perf/core the problem disappeared. :)
>>>
>>I was only trying it with tip.git. The patch looke simple enough to
>>apply
>>to tip.git but clearly it relies on some other infrastructure changes
>>which
>>I don't know about. In my case =3D, I care about getting this feature=
 in
>>tip.git
>>or older versions of perf.
>
> It is all in tip.git by now.
>
>>> But unfortunately I got this segfault instead..
>
> Needs a patch that is in perf/urgent
>
If I pull tip.git now. Does it have what is needed to work?
