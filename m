Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D6372B35
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245927; cv=none; b=VgjD3RVAVSeKTPq5lih6UnaTLvqPOQhBz4VdyRJdlHg1WSRjiMVUWvFTB6IvKnK6Q4NIc1GPdbdfCYzJqi68AY1FffvmrfZX3mVdQeQ8xYJu3eowijjyZ0HtE8rk48dMBXFs+rAZhLY3Ec45j2cnA3tf6alLTITK1/zSJxVF+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245927; c=relaxed/simple;
	bh=lA74KKEsFlEiK5fCJTfVaV55Sip0KT13xTOJd/9Q+T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVUHDdZmNahMJoBB9C4s92FJ4IEOgEbErIL32/ewqsSvTTStwFlfMCThiz+Jdy+bmdj/6pFsbEPKZPoeN5zTTLaVQAVtFMQ/D+L0LgSue2gwvKd8qZiQBpxY+9mdklDdgz0pPq4cpc1nkV6vkj40KWgDfxJqKzwkHVusxJTv98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfVt+LXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfVt+LXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F7AC4CEF7;
	Wed, 11 Mar 2026 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773245927;
	bh=lA74KKEsFlEiK5fCJTfVaV55Sip0KT13xTOJd/9Q+T4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nfVt+LXj5oKqSrYYswf3gZfz2Zg4XUIYNNdL6UdL73DSEcifayq3KOmBB3zroY7F8
	 ETZpATb9/N2B6bwOARNe5a+BZPuHxmkZ3iDrP79riNeR80PiNjX4MFmYRRdgjxqPgp
	 m5ifQfigppIiJH7XgH6MqKABTZHcE4NXc7924ju8rVka4gq5Pr/XVm8o1vVjvXOTbZ
	 Q4b6JbXLySSx1dITKwQkkKJxvCLWR12uIEGW/4vgvjw4KGVfXe88SXk29p7805bjr5
	 RE207aI2LNypu1MPqIEeKDiF5jMld4tcXY4LhN8qYXonqGsrUkTc+JghHySVxzyd5i
	 1VyA21BXrsf1w==
Message-ID: <c0331aeb-a0ad-498e-83c0-1a986db4e2ef@kernel.org>
Date: Wed, 11 Mar 2026 12:18:45 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf synthetic-events: Fix stale build ID in module
 MMAP2 records
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20260310175951.29500-1-cel@kernel.org>
 <CAP-5=fUA0BiCfgqgy_ik8iAhABQxYtFhKiUiEGrOCcF2jAqhfQ@mail.gmail.com>
 <CAP-5=fVVxqt9Po-dokuP8dOJ+VN1Zrzgx6hVJ=cXgkW8f8dhvA@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <CAP-5=fVVxqt9Po-dokuP8dOJ+VN1Zrzgx6hVJ=cXgkW8f8dhvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/11/26 12:14 PM, Ian Rogers wrote:
> On Tue, Mar 10, 2026 at 12:32 PM Ian Rogers <irogers@google.com> wrote:
>>
>> On Tue, Mar 10, 2026 at 10:59 AM Chuck Lever <cel@kernel.org> wrote:
>>>
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> perf_event__synthesize_modules() allocates a single union
>>> perf_event and reuses it across every kernel module callback.
>>> After the first module is processed,
>>> perf_record_mmap2__read_build_id() sets
>>> PERF_RECORD_MISC_MMAP_BUILD_ID in header.misc and writes that
>>> module's build ID into the event. On subsequent iterations the
>>> callback overwrites start, len, pid, and filename for the next
>>> module but never clears the stale build ID fields or the
>>> MMAP_BUILD_ID flag. When perf_record_mmap2__read_build_id()
>>> runs for the second module it sees the flag, reads the stale
>>> build ID into a dso_id, and __dso__improve_id() permanently
>>> poisons the DSO with the wrong build ID. Every module after
>>> the first therefore receives the first module's build ID in
>>> its MMAP2 record. On a system with the sunrpc and nfsd modules
>>> loaded, this causes perf script and perf report to show
>>> [unknown] for all module symbols.
>>>
>>> The latent bug has existed since commit d9f2ecbc5e47 ("perf
>>> dso: Move build_id to dso_id") introduced the
>>> PERF_RECORD_MISC_MMAP_BUILD_ID check in
>>> perf_record_mmap2__read_build_id(). Commit 53b00ff358dc ("perf
>>> record: Make --buildid-mmap the default") then exposed it to
>>> all users by making the MMAP2-with-build-ID path the default.
>>> Both commits were merged in the same series.
>>>
>>> Clear the MMAP_BUILD_ID flag and zero the build_id union
>>> before each call to perf_record_mmap2__read_build_id() so
>>> that every module starts with a clean slate.
>>>
>>> Fixes: d9f2ecbc5e47 ("perf dso: Move build_id to dso_id")
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>  tools/perf/util/synthetic-events.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
>>> index ef79433ebc3a..ddf1cbda1902 100644
>>> --- a/tools/perf/util/synthetic-events.c
>>> +++ b/tools/perf/util/synthetic-events.c
>>> @@ -703,6 +703,11 @@ static int perf_event__synthesize_modules_maps_cb(struct map *map, void *data)
>>>
>>>                 memcpy(event->mmap2.filename, dso__long_name(dso), dso__long_name_len(dso) + 1);
> 
> AI points out that leaving stale data isn't just a problem for misc
> bits but also after the filename, due to the event's alignment to 8
> bytes. I think this is benign, you're only leaking bits of the
> filename from the last event, not uninitialized data from the perf
> execution. The AI made me think about it so I thought I'd  repeat it.
> We could add a memset here to clear the filename up to the alignment,
> as is done here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/synthetic-events.c?h=perf-tools-next#n529
> ```
> memset(event->mmap2.filename + size, 0, machine->id_hdr_size +
>         (aligned_size - size));
> ```

Hi Ian,

I'm not attached to the exact way this issue is addressed, so if
you know of improvements, please feel free to incorporate them.


-- 
Chuck Lever
