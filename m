From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v4] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Date: Sun, 16 Feb 2020 21:21:43 +0100
Message-ID: <20200216202143.GA145986@krava>
References: <20200212054102.9259-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200212054102.9259-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jin Yao <yao.jin@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Feb 12, 2020 at 11:11:02AM +0530, Kajol Jain wrote:

SNIP

> =20
>  	return metric_events[0];
> @@ -160,6 +161,14 @@ static int metricgroup__setup_events(struct list_h=
ead *groups,
>  	int ret =3D 0;
>  	struct egroup *eg;
>  	struct evsel *evsel;
> +	bool *evlist_used;
> +
> +	evlist_used =3D (bool *)calloc(perf_evlist->core.nr_entries,
> +				     sizeof(bool));
> +	if (!evlist_used) {
> +		ret =3D -ENOMEM;
> +		break;

hum, how did this compile for you? ;-)

util/metricgroup.c: In function =E2=80=98metricgroup__setup_events=E2=80=99=
:
util/metricgroup.c:170:3: error: break statement not within loop or switc=
h
  170 |   break;


jirka
