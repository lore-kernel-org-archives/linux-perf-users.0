Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960CCA4E;
	Thu,  3 Apr 2025 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743640944; cv=none; b=f6DO0gR8xXoMQ5JSo07bYAv9JPP4JC7w38rpXPBgzyEAKJSfs31nJihizwN3mIPeXkgU4WXp13NGilDUzs7GL8hhqRpvLu12Yqmt8e8rYnrDeNPouSE6XfdNB6Kt/pjW08X8GYv/WnlspmibJ5rPSlTGP380xHdKx9in3c6e3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743640944; c=relaxed/simple;
	bh=v8rHehhqVOxlt1wr0Mz10HT90Tv6jF57Kb/uEFy75mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcwXSeatpHJwSr50iRcUFNHFs2GqOjllEdVePlwfPqo2T8YCnxclqhX5X38EUM+MFVG25YP7l1zmZbMH11LR6YPi2X5l8JuyKiE3ONv5S/KDfhlVOljSYox7obI5sY3dVDNuAKaKG8gOYFYTxerpCys/OHK7D2jJDZShP7iyX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhCxyamk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhCxyamk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743640943; x=1775176943;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v8rHehhqVOxlt1wr0Mz10HT90Tv6jF57Kb/uEFy75mc=;
  b=jhCxyamkyob7dCkyhB5RzZ/Pe5yszNZr+RyFJeNKdm/8dtyWfIqPjgyj
   UU7ss4EYZJuTfESQO+Hb05Nf0ABVuy03k1UhQeY4FORbY7BJNfzF2dlgy
   m6Mg5mOUYpQzHySvOi8nRYQJYvycWKlNh+8oIQHGf+A/8pqYnHiGx70pe
   GGMa5UHryCZO+7XQAOC1t6uEM3ML51E+Q9MC69ovyTw+DChO/ThmuY8A0
   KB6Zsde4yysaGLjRcDhJO8SjS2mc3wI82EOsSy9YmW8+QNRYqZgO24hL4
   PTYgNTRn7G7MADlEGBwD96zT85l4y/AN0FoJHsyZAtVRNT658H5I4JhMa
   A==;
X-CSE-ConnectionGUID: /Fzs8SjDQLWO1b+hTjheFQ==
X-CSE-MsgGUID: vcme71q1TLCS+/5HTxpe4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="62433325"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="62433325"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 17:42:22 -0700
X-CSE-ConnectionGUID: N6SwP/yPTce7spY0fYF4+A==
X-CSE-MsgGUID: aIWOfQczTHOhrQngkRtj6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="131561837"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 17:42:19 -0700
Message-ID: <762e01c1-c78c-4bd7-aec4-4cc56563da20@linux.intel.com>
Date: Thu, 3 Apr 2025 08:42:16 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Fix incorrect --user-regs comments
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250402082106.103318-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fU3Tam3PXd94ibVQZU=Kk4Q_=z0i9o7kx-Vgm9qwK-mHA@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fU3Tam3PXd94ibVQZU=Kk4Q_=z0i9o7kx-Vgm9qwK-mHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/3/2025 12:55 AM, Ian Rogers wrote:
> On Tue, Apr 1, 2025 at 8:58 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> The comment of "--user-regs" option is not correct, fix it.
>>
>> "on interrupt," -> "on user space,"
> nit: I think "in user space" is more grammatical.

Sure.


>
>> Fixes: 84c417422798 ("perf record: Support direct --user-regs arguments")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/builtin-record.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index ba20bf7c011d..f21b133691d7 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -3480,7 +3480,7 @@ static struct option __record_options[] = {
>>                     "sample selected machine registers on interrupt,"
>>                     " use '-I?' to list register names", parse_intr_regs),
>>         OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
>> -                   "sample selected machine registers on interrupt,"
>> +                   "sample selected machine registers on user space,"
> nit: "sample selected machine registers in user space"
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Sure. Thanks for reviewing.


>
> Thanks,
> Ian
>
>>                     " use '--user-regs=?' to list register names", parse_user_regs),
>>         OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
>>                     "Record running/enabled time of read (:S) events"),
>>
>> base-commit: 35d13f841a3d8159ef20d5e32a9ed3faa27875bc
>> --
>> 2.40.1
>>
