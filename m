Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412EA340D8D;
	Thu,  4 Sep 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008420; cv=none; b=bGYQ0YdnWm5JB81FOfytOzBsDb50yDOqD9aA2cPQhpZHQVAfTgAc8UUkWvzTdXzeBRh7vujceOJv9DZFh0PMZKIm3VG0pVtC1YBrlMhz7Ngr7gtee9uAGGhZfHt1O0FeUdKUictneQaIQBYr+XGfbpTbYozy+Un3uXix2OgS4lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008420; c=relaxed/simple;
	bh=+8hnTNAfGxD28SiMG6Wv5m9VqZr1vU5rTDf1pWmRUy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ETH0DOTVEk44PAK6DPFq3v5YHgp5sVcFdSGKyZ8oUXXHJeTZhZFFLZRaVqXDHZ1KZoUSdcwCaVZpJ5UXnUyWhnvKR+JRBA10UiOtvhKd8QwosVPbCIah2zy0xD27nKRSS3ic0ICV8V0EktKnSQyNXYEpQw1WVvELvTx6wrq1IBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 50F2C340CE7;
	Thu, 04 Sep 2025 17:53:36 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 amadio@gentoo.org, dlan@gentoo.org
Cc: James Clark <james.clark@linaro.org>,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Arnaldo Carvalho
 de Melo <acme@kernel.org>,  Namhyung Kim <namhyung@kernel.org>,  Mark
 Rutland <mark.rutland@arm.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,
  Adrian Hunter <adrian.hunter@intel.com>,  Leo Yan <leo.yan@arm.com>,
  linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
In-Reply-To: <CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
Organization: Gentoo
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
	<20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
	<CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Thu, 04 Sep 2025 18:53:33 +0100
Message-ID: <87o6rqkste.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ian Rogers <irogers@google.com> writes:

> On Wed, Sep 3, 2025 at 8:15=E2=80=AFAM James Clark <james.clark@linaro.or=
g> wrote:
>>
>> read_build_id() now has a blocking argument, but libbfd uses fopen()
>> internally which doesn't support O_NONBLOCK. Fix the build by adding the
>> argument and ignoring it:
>>
>>   util/symbol-elf.c:964:8: error: too many arguments to function =E2=80=
=98read_build_id=E2=80=99
>>     964 |  err =3D read_build_id(filename, bid, block);
>>
>> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__re=
ad_build_id")
>> Signed-off-by: James Clark <james.clark@linaro.org>
>
> Libbfd should go away:
> https://lore.kernel.org/lkml/20250823003216.733941-14-irogers@google.com/
> but I can imagine that currently this is hit in a build test - sorry
> for missing that and thanks for the fix!
>
> We should probably honor the blocking argument (use fdopen) as the
> probe perf tests will invoke perf record system wide with data pages
> and predictably hang on this for files like mmap-ed in sound devices.
> That said, maybe this hanging will serve as an indication not to use
> the deprecated libbfd code. From the sounds of things this will break
> gentoo :-(
> https://lore.kernel.org/lkml/87ldnacz33.fsf@gentoo.org/

Just want to say I haven't forgot about this, I need to find a moment to
compare the bfd and nonbfd builds to see if everything works OK
now. Will try do that in the next few days.

The disassembler/objdump use was definitely the biggest problem so if
support for binutils is here to say there, that puts my mind at ease.

Has Andi mentioned what issue he had? amadio/dlan, can you weigh in as well?

>
> Thanks,
> Ian
>
>> ---
>>  tools/perf/util/symbol-elf.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index 033c79231a54..e0d6ff7d0acf 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -873,7 +873,8 @@ static int elf_read_build_id(Elf *elf, void *bf, siz=
e_t size)
>>
>>  #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
>>
>> -static int read_build_id(const char *filename, struct build_id *bid)
>> +static int read_build_id(const char *filename, struct build_id *bid,
>> +                        bool block __maybe_unused)
>>  {
>>         size_t size =3D sizeof(bid->data);
>>         int err =3D -1;
>>
>> --
>> 2.34.1
>>
