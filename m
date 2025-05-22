Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA2280311;
	Thu, 22 May 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953469; cv=none; b=COiHlGAlqaMe2aS9VGsiIPTwSu69Ug9SMMfoESXqc9yHxSQQ8p032AxtUIjuqYn0lLZF/Imwyoi5YIZSZMqiaOMarfz0UJEua/FtkXolP5mjX3hgcsHZNYczzOUs0QSSMo0rB5bkTZqIq9lpY/Bdxye5uoO6sY3bhtnDB/ru0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953469; c=relaxed/simple;
	bh=wAYw4cAScuwWFKUFB4xQmNEcChfCTqByK7DhFmO09p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IumBKsxB9CVi1beBWHPpNvQMbS1kwUAr/VYhZDH03/yralwDap0vJsZb1FhwCXtS9LDh3OYbrBcIX/d7KiWw/eJy/OyJ4wVH1BOCo9E4yraRT2aUt0/deWzwZKHOrCKLVNW46LHHL+aQywAXb0sCo/owMe+zzDTFYnxzu9GuY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrXF/OL/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrXF/OL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AB9C4CEEB;
	Thu, 22 May 2025 22:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747953469;
	bh=wAYw4cAScuwWFKUFB4xQmNEcChfCTqByK7DhFmO09p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrXF/OL/+3isBGPYBrjoDcQAr1mTj6ZU6IIttlTkSuTE3ef6CNFIy+A92GyzGkOnV
	 sydzDF5gmTUwYpMF+HeeI9eeBoaEPDmTELFsiRLiAYmPmKfQ4sSISamRj+lUIzWdC/
	 pG541ruW02i7X1Nxn93KYTaZDmJlWp3xVefrdGDaXzD6dnb7w49DAa5LRH/GR0yfJY
	 QwX1BnXxUpDxyVRa3t0gmVHaYaoh5X5RbEDwG8Eeep6HUZzPkDsSKVUo9P5dV7HBCE
	 408MyxNNr8eZVTL+Uwsh2SAbjzbZ7+b0TJ5EhKrZ6STz9ZT0jKC5g2M+vvBrrlzEgg
	 coK8E84c99Hkw==
Date: Thu, 22 May 2025 19:37:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com
Subject: Re: [PATCH v3 4/7] perf python: Add support for perf_counts_values
 to return counter data
Message-ID: <aC-nOmMADRlnqkP8@x1>
References: <20250519195148.1708988-1-irogers@google.com>
 <20250519195148.1708988-5-irogers@google.com>
 <aC-jR0b3mji4oJ7Q@x1>
 <CAP-5=fXdpT3-=e4cqZN4fBJK1c4TnYC1ZVV5Q5zTjmf7T7Fffg@mail.gmail.com>
 <aC-m7G-AVJP6sDD3@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aC-m7G-AVJP6sDD3@x1>

On Thu, May 22, 2025 at 07:36:31PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, May 22, 2025 at 03:32:44PM -0700, Ian Rogers wrote:
> > On Thu, May 22, 2025 at 3:20 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Mon, May 19, 2025 at 12:51:41PM -0700, Ian Rogers wrote:
> > > > From: Gautam Menghani <gautam@linux.ibm.com>
> > > >
> > > > Add support for perf_counts_values struct to enable the python
> > > > bindings to read and return the counter data.
> > > >
> > > > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > > > ---
> > > >  tools/perf/util/python.c | 92 +++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 91 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > > > index ead3afd2d996..1cbddfe77c7c 100644
> > > > --- a/tools/perf/util/python.c
> > > > +++ b/tools/perf/util/python.c
> > > > @@ -626,6 +626,92 @@ static int pyrf_thread_map__setup_types(void)
> > > >       return PyType_Ready(&pyrf_thread_map__type);
> > > >  }
> > > >
> > > > +struct pyrf_counts_values {
> > > > +     PyObject_HEAD
> > > > +
> > > > +     struct perf_counts_values values;
> > > > +};
> > > > +
> > > > +static const char pyrf_counts_values__doc[] = PyDoc_STR("perf counts values object.");
> > > > +
> > > > +static void pyrf_counts_values__delete(struct pyrf_counts_values *pcounts_values)
> > > > +{
> > > > +     Py_TYPE(pcounts_values)->tp_free((PyObject *)pcounts_values);
> > > > +}
> > > > +
> > > > +#define counts_values_member_def(member, ptype, help) \
> > > > +     { #member, ptype, \
> > > > +       offsetof(struct pyrf_counts_values, values.member), \
> > > > +       0, help }
> > > > +
> > > > +static PyMemberDef pyrf_counts_values_members[] = {
> > > > +     counts_values_member_def(val, Py_T_ULONG, "Value of event"),
> > > > +     counts_values_member_def(ena, Py_T_ULONG, "Time for which enabled"),
> > > > +     counts_values_member_def(run, Py_T_ULONG, "Time for which running"),
> > > > +     counts_values_member_def(id, Py_T_ULONG, "Unique ID for an event"),
> > > > +     counts_values_member_def(lost, Py_T_ULONG, "Num of lost samples"),
> > > > +     {NULL}
> > > > +};
> > >
> > > So the above is failing on a aarch64 debian (rpi5):
> > >
> > > acme@raspberrypi:~/git/perf-tools-next $ dpkg -S /usr/include/python3.11/structmember.h
> > > libpython3.11-dev:arm64: /usr/include/python3.11/structmember.h
> > > acme@raspberrypi:~/git/perf-tools-next $
> > >
> > > Where it only has:
> > >
> > > acme@raspberrypi:~/git/perf-tools-next $ grep -r Py_T_ULONG /usr/include/
> > > acme@raspberrypi:~/git/perf-tools-next $ grep -rw Py_T_ULONG /usr/include/
> > > acme@raspberrypi:~/git/perf-tools-next $ grep -rw T_ULONG /usr/include/
> > > /usr/include/python3.11/structmember.h:#define T_ULONG     12
> > > acme@raspberrypi:~/git/perf-tools-next $
> > >
> > > while on fedora 42 x86_64:
> > >
> > > ⬢ [acme@toolbx perf-tools-next]$ grep -rw Py_T_ULONG /usr/include/
> > > /usr/include/python3.13/descrobject.h:#define Py_T_ULONG     12
> > > /usr/include/python3.13/structmember.h:#define T_ULONG     Py_T_ULONG
> > > ⬢ [acme@toolbx perf-tools-next]$
> > >
> > > So I'm making it use the T_ULONG and others as all the other PyMemberDef
> > > arrays in tools/perf/util/python.c, ok?
> > 
> > The fix makes sense to me. Checking the documentation it seems
> > Py_T_ULONG is preferred:
> > https://docs.python.org/3/c-api/structures.html#member-types
> > perhaps we can add:
> > ```
> > #ifndef Py_T_ULONG
> > #define Py_T_ULONG T_ULONG
> > #endif
> > ```
> > so that we use the approach matching the documentation while fixing
> > the RaspberryPi issue.
> 
> That can be done as a followup, as there are lots of preexisting usage
> for struct method definitions.

And there is one other issue:

  LINK    /tmp/build/perf/perf
  GEN     /tmp/build/perf/python/perf.cpython-36m-x86_64-linux-gnu.so
/git/perf-6.15.0-rc7/tools/perf/util/python.c:653:7: error: missing field 'type' initializer [-Werror,-Wmissing-field-initializers]
  653 |         {NULL}
      |              ^
/git/perf-6.15.0-rc7/tools/perf/util/python.c:695:7: error: missing field 'get' initializer [-Werror,-Wmissing-field-initializers]
  695 |         {NULL}
      |              ^
2 errors generated.
error: command 'clang' failed with exit status 1
cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No such file or directory


I'll look at this after dinner.

- Arnaldo
