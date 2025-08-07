Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FFB79EA;
	Thu,  7 Aug 2025 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754535084; cv=none; b=oKcIHuhbzaJOvxFR8oSpkMP4uJbvw1ES7x6HDnPkXQI8S/8UDky/+WpUI1SlXR4mi9KrXIrU4kBmehpQYoeSDnaJrHvcuUGDsNsIecYhO+SkK7wDl9aJlKsdZOmGEYbjDDz2DTYgmKHzaZO8yMwUvUfom/kWZU5VuzGYja9+tmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754535084; c=relaxed/simple;
	bh=vNKcBICRt0gpOhUNPqPd86752k5yVrJIW8FRc0yP5Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kry9xmr9A96xmBGsscDL+cMhj9JbJH/agHypHZE9WRihGRdeBmiUypUJoIBpjEa7QuyoWSKzsUJb+UZtmqT/fLuNyBDhuHPiRVfg9dqMi+9LNn7JMi8WHhdofJ8fT9wb0r1rJflEegfpvkctZNmB6/VfIW4XIOzu6L4LoxyK7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwkQtqVI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwkQtqVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754535083; x=1786071083;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vNKcBICRt0gpOhUNPqPd86752k5yVrJIW8FRc0yP5Zs=;
  b=XwkQtqVIjrD+wU/agkuvZmdk5Ie7JQpvf451T/Xd6YGcHlxt9FPkzZV9
   Xa4AViGEiAViUDfdlfkSZbNTP9JXWD7Gnd65VUz0xDQwwANiMMqdwLhKW
   zX6EE52e7lxRbOFRkBMiCpEG2kgn7DvaC49jtb0lwfuS9+otDpZEby7x9
   RncwALo54g/47BlKP2mtNfqrxLAStqBcbTssDzCYFbE6FYoj8WZTuxYwT
   uuUcenjfcgGPKIpVfVRGjXAuLA8Tz4gkp3jy8k/rClp1N76JymAT7sSk3
   VfLg15p35xbFYqvilGV7+IQkVnVh4vF1aNf3sHpO7NYvHCEpXGYe6mCZz
   g==;
X-CSE-ConnectionGUID: ynKOmBXvS5uvr0hV1+hyHQ==
X-CSE-MsgGUID: Uigq02uOTviHx5KDdla7nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56938105"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56938105"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 19:51:23 -0700
X-CSE-ConnectionGUID: sCQdZdSSRUuIqfnZtwPDVQ==
X-CSE-MsgGUID: tMkfoCwiSiWHZyNYgUeNcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165733074"
Received: from leiliu4-mobl1.ccr.corp.intel.com (HELO [10.124.240.106]) ([10.124.240.106])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 19:51:20 -0700
Message-ID: <9cac1ec3-fd5f-4f20-842e-9903642126a3@linux.intel.com>
Date: Thu, 7 Aug 2025 10:51:17 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] perf tools kvm: Add missed memory allocation check
 and free
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
 <20250805004633.135904-2-dapeng1.mi@linux.intel.com>
 <aJPn1Z5zxqOjZ-Ym@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aJPn1Z5zxqOjZ-Ym@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/7/2025 7:40 AM, Namhyung Kim wrote:
> On Tue, Aug 05, 2025 at 08:46:29AM +0800, Dapeng Mi wrote:
>> Current code allocates rec_argv[] array, but doesn't check if the
>> allocation is successful and explicitly free the rec_argv[] array.
>>
>> Add them back.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/builtin-kvm.c | 29 +++++++++++++++++++++++------
>>  1 file changed, 23 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
>> index 7b15b4a705e4..f78a67a199ff 100644
>> --- a/tools/perf/builtin-kvm.c
>> +++ b/tools/perf/builtin-kvm.c
>> @@ -1719,7 +1719,9 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
>>  	set_option_flag(record_options, 0, "transaction", PARSE_OPT_DISABLED);
>>  
>>  	record_usage = kvm_stat_record_usage;
>> -	return cmd_record(i, rec_argv);
>> +	ret = cmd_record(i, rec_argv);
>> +	free(rec_argv);
> Well.. it's not enough just to free rec_argv.  You also need to free all
> items in the rec_argv[].  Probably you want to add more STRDUP_FAIL_EXIT
> when copying the original argv (here and other places).

Oh, yes. Would do. Thanks. 


>
> Thanks,
> Namhyung
>
>
>> +	return ret;
>>  }
>>  
>>  static int
>> @@ -2006,6 +2008,9 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
>>  
>>  	rec_argc = argc + 2;
>>  	rec_argv = calloc(rec_argc + 1, sizeof(char *));
>> +	if (!rec_argv)
>> +		return -ENOMEM;
>> +
>>  	rec_argv[i++] = strdup("record");
>>  	rec_argv[i++] = strdup("-o");
>>  	rec_argv[i++] = strdup(file_name);
>> @@ -2014,16 +2019,21 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
>>  
>>  	BUG_ON(i != rec_argc);
>>  
>> -	return cmd_record(i, rec_argv);
>> +	ret = cmd_record(i, rec_argv);
>> +	free(rec_argv);
>> +	return ret;
>>  }
>>  
>>  static int __cmd_report(const char *file_name, int argc, const char **argv)
>>  {
>> -	int rec_argc, i = 0, j;
>> +	int rec_argc, i = 0, j, ret;
>>  	const char **rec_argv;
>>  
>>  	rec_argc = argc + 2;
>>  	rec_argv = calloc(rec_argc + 1, sizeof(char *));
>> +	if (!rec_argv)
>> +		return -ENOMEM;
>> +
>>  	rec_argv[i++] = strdup("report");
>>  	rec_argv[i++] = strdup("-i");
>>  	rec_argv[i++] = strdup(file_name);
>> @@ -2032,17 +2042,22 @@ static int __cmd_report(const char *file_name, int argc, const char **argv)
>>  
>>  	BUG_ON(i != rec_argc);
>>  
>> -	return cmd_report(i, rec_argv);
>> +	ret = cmd_report(i, rec_argv);
>> +	free(rec_argv);
>> +	return ret;
>>  }
>>  
>>  static int
>>  __cmd_buildid_list(const char *file_name, int argc, const char **argv)
>>  {
>> -	int rec_argc, i = 0, j;
>> +	int rec_argc, i = 0, j, ret;
>>  	const char **rec_argv;
>>  
>>  	rec_argc = argc + 2;
>>  	rec_argv = calloc(rec_argc + 1, sizeof(char *));
>> +	if (!rec_argv)
>> +		return -ENOMEM;
>> +
>>  	rec_argv[i++] = strdup("buildid-list");
>>  	rec_argv[i++] = strdup("-i");
>>  	rec_argv[i++] = strdup(file_name);
>> @@ -2051,7 +2066,9 @@ __cmd_buildid_list(const char *file_name, int argc, const char **argv)
>>  
>>  	BUG_ON(i != rec_argc);
>>  
>> -	return cmd_buildid_list(i, rec_argv);
>> +	ret = cmd_buildid_list(i, rec_argv);
>> +	free(rec_argv);
>> +	return ret;
>>  }
>>  
>>  int cmd_kvm(int argc, const char **argv)
>> -- 
>> 2.34.1
>>
