From: Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH v2 0/7] perf script python: add Python3 support
Date: Tue, 5 Mar 2019 07:18:30 -0800
Message-ID: <59f76d80-ed24-dd88-b3ae-baea39f08499@suse.de>
References: <20190302011903.2416-1-tonyj@suse.de>
 <ef75a243-cf15-b763-8aeb-387f105377c6@intel.com>
 <962077f0-71c6-e2e8-7274-875b55470a3e@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <962077f0-71c6-e2e8-7274-875b55470a3e@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Feng Tang <feng.tang@intel.com>, Tom Zanussi <tzanussi@gmail.com>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On 3/5/19 6:53 AM, Tony Jones wrote:
> On 3/5/19 1:55 AM, Adrian Hunter wrote:
> 
>> perf tools link against python2 so have the scripts been tested with python3?
> 
> Not if PYTHON=python3 is specified on the build line.   Yes, of course they were tested.

See below for exporter.  The viewer also works but obviously harder to demonstrate via log.

$ make PYTHON=python3 prefix=/tmp/perf install
$ ldd /tmp/perf/bin/perf | grep python
	libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007f90d32c3000)

# /tmp/perf/bin/perf record -o /tmp/perf.data -e cycles,instructions,branches /bin/false
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.017 MB /tmp/perf.data (39 samples) ]

postgres@svr1:~> id
uid=26(postgres) gid=26(postgres) groups=26(postgres)

postgres@svr1:~> ldd /tmp/perf/bin/perf | grep python
	libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007f7714156000)

postgres@svr1:~> /tmp/perf/bin/perf script -i /tmp/perf.data -s /tmp/perf/libexec/perf-core/scripts/python/export-to-postgresql.py db1
2019-03-05 07:14:04.243419 Creating database...
This version of PostgreSQL is not supported and may not work.
This version of PostgreSQL is not supported and may not work.
2019-03-05 07:14:05.122981 Writing to intermediate files...
2019-03-05 07:14:05.187927 Copying to database...
2019-03-05 07:14:05.222272 Removing intermediate files...
2019-03-05 07:14:05.222766 Adding primary keys
2019-03-05 07:14:05.714776 Adding foreign keys

postgres@svr1:~> pg_dump -a -t public.comms -t public.dsos db1
--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
-- Dumped by pg_dump version 10.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: comms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comms (id, comm) FROM stdin;
0	unknown
1	perf
2	false
\.


--
-- Data for Name: dsos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dsos (id, machine_id, short_name, long_name, build_id) FROM stdin;
0	0	unknown	unknown	
1	1	[kernel.kallsyms]	[kernel.kallsyms]	0621827fb34281c413e26a0c2d6ba1c0abd706b9
2	1	ld-2.26.so	/lib64/ld-2.26.so	bca321ae4ce1ab788b186e2085f60c1c9723cc14
\.


--
-- PostgreSQL database dump complete
--
