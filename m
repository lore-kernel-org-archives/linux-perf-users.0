Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A600145A03;
	Thu, 21 Nov 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732223298; cv=none; b=GJk9MmUla4dZidA3NqT76vCniDdkBVqNf91u4oaBIclER8wBdjGGrqyPaw7Lyq2c7x0TH5cSQTeaFWZS8dT2HfYkiNc5Ws46JFpLLfw51Xrl+pQkgGYIcRCvcGBl/sQIfQQ1L6ie9YTFlOXjlcAYyxXfdil4BxzaxZExbWOF/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732223298; c=relaxed/simple;
	bh=fXt8OxKD9XX5qaiVShNhnVnQCT5t1Ne8v6HujS5jMVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9hT18y307WDV6BTTNnYfYY/9vHAAdQaU3fajQmyydR8BQ+tq2Wi2Fab1HRL5x/nA9yLjKvZ3EEaxvJcUgD+FKwBt1h6LdzCmu1cTEg851T7HMqX7jci+1P1q+ND0CBjwghF9hhKSuyGvpUAgbEFjXomt1iVykAlNfbH5ATLysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qz+C2QVT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qz+C2QVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284D3C4CECC;
	Thu, 21 Nov 2024 21:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732223297;
	bh=fXt8OxKD9XX5qaiVShNhnVnQCT5t1Ne8v6HujS5jMVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qz+C2QVTzAuv07xeo7NfDGTUpe22VVE87opo3nmV7QIeSMhgz0WnzCYAuMVQfME2Y
	 Z+X+L8SzHZgtzL0SHtIlaHZRi2DfX7o8RVM/aRHx4loPcZyFgInRHs48dL2r8QZdT+
	 Oj/bnwqDxuMN5i+uRYIyrtoJLxJW9jVAvYowsmrdsVqa35A8vZaHWmXIj5DGHnJ57e
	 lwXu0Ltb39W3f8Qy0PbjZ4he+7IO5glzXYg9ObW83CKAvsfORjeENkjmdF4AsJ4i8s
	 DIZSA4Y7AEz6LU4S0IuetnBmTzF/0Skw2snVMy1lp4xHQRYd9pptSkob6FU62ifIsh
	 6fwtQskaAl1jg==
Date: Thu, 21 Nov 2024 18:08:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf tests: Fix hwmon parsing with PMU name test
Message-ID: <Zz-hPtbuqzDd7t00@x1>
References: <20241121000955.536930-1-irogers@google.com>
 <Zz9oKR3goFPP9_a9@x1>
 <Zz9sbNAuRsYjclAi@x1>
 <CAP-5=fXAitSZuRPppAjH=38Ua6BFyhou0sSj7xmfNakqPUQqPw@mail.gmail.com>
 <Zz-e4fMLIJmufgyl@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz-e4fMLIJmufgyl@x1>

On Thu, Nov 21, 2024 at 05:58:09PM -0300, Arnaldo Carvalho de Melo wrote:
> root@number:~# perf probe -x ~/bin/perf -L hwmon_pmu__have_event
> <hwmon_pmu__have_event@/home/acme/git/perf-tools-next/tools/perf/util/hwmon_pmu.c:0>
>       0  bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
>       1  {
>       2         struct hwmon_pmu *hwm = container_of(pmu, struct hwmon_pmu, pmu);
>                 enum hwmon_type type;
>                 int number;
>       5         union hwmon_pmu_event_key key = { .type_and_num = 0 };
>                 struct hashmap_entry *cur;
>                 size_t bkt;
>          
>       9         if (!parse_hwmon_filename(name, &type, &number, /*item=*/NULL, /*is_alarm=*/NULL))
>      10                 return false;
>          
>      12         if (hwmon_pmu__read_events(hwm))
>      13                 return false;
>          
>      15         key.type = type;
>      16         key.num = number;
>      17         if (hashmap_find(&hwm->events, key.type_and_num, /*value=*/NULL))
>      18                 return true;
>      19         if (key.num != -1)
>      20                 return false;
>                 /* Item is of form <type>_ which means we should match <type>_<label>. */
>      22         hashmap__for_each_entry((&hwm->events), cur, bkt) {
>      23                 struct hwmon_pmu_event_value *value = cur->pvalue;
>          
>      25                 key.type_and_num = cur->key;
>      26                 if (key.type == type && value->name && !strcasecmp(name, value->name))
>      27                         return true;
>                 }
>      29         return false;
>      30  }

To read all the values it looks for in the hashmap:

root@number:~# perf probe -x ~/bin/perf hwmon_pmu__have_event:25 'value->name:string'
Added new events:
  probe_perf:hwmon_pmu__have_event_L25 (on hwmon_pmu__have_event:25 in /home/acme/bin/perf with name=value->name:string)
  probe_perf:hwmon_pmu__have_event_L25 (on hwmon_pmu__have_event:25 in /home/acme/bin/perf with name=value->name:string)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:hwmon_pmu__have_event_L25 -aR sleep 1

root@number:~#

root@number:~# perf trace --libtrace -e probe_perf:* perf test -F 11
 11.1: Basic parsing test                                            : Ok
     0.000 :147400/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="cpu0_accuracy")
     0.044 :147400/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_input")
     0.054 :147400/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="fan2_vid")
     0.062 :147400/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="power3_crit_alarm")
     0.069 :147400/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="intrusion4_average_interval_min_alarm")
     0.076 :147400/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="badtype5_baditem")
     0.083 :147400/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="humidity6_baditem")
     1.936 perf/147400 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     1.938 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     1.942 perf/147400 probe_perf:hwmon_pmu__have_event_L29((66135d))
     1.944 perf/147400 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     1.945 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     1.949 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="uevent")
     1.950 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_input")
     1.952 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="name")
     1.954 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp2_input")
     1.957 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="")
     1.959 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="")
     1.961 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="")
     1.962 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="")
     1.964 perf/147400 probe_perf:hwmon_pmu__have_event_L29((66135d))
     1.965 perf/147400 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     1.966 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     1.991 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp42_input")
     1.993 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp26_input")
     1.994 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="uevent")
     1.996 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp10_crit_alarm")
     1.997 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp35_crit_alarm")
     1.999 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp37_max")
     2.001 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp30_label")
     2.005 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp34_crit")
     2.006 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp14_label")
     2.010 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp36_input")
     2.011 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp40_max")
     2.013 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp6_input")
     2.014 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp22_crit")
     2.016 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp40_label")
     2.019 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp44_max")
     2.021 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp2_crit_alarm")
     2.023 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp44_crit_alarm")
     2.024 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp10_crit")
     2.026 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp34_label")
     2.029 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp18_label")
     2.032 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp45_crit")
     2.034 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp2_crit")
     2.035 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp2_max")
     2.037 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp44_label")
     2.040 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp6_max")
     2.041 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp30_max")
     2.042 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp38_crit_alarm")
     2.044 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp34_max")
     2.045 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp39_crit")
     2.047 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp38_label")
     2.050 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp43_input")
     2.051 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp18_crit_alarm")
     2.053 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp38_max")
     2.054 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp42_crit_alarm")
     2.056 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp10_input")
     2.057 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp44_crit")
     2.059 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_label")
     2.063 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp41_max")
     2.064 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp22_crit_alarm")
     2.066 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_crit")
     2.067 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp37_input")
     2.069 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp45_max")
     2.070 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp41_label")
     2.074 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp30_input")
     2.075 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp14_input")
     2.077 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp38_crit")
     2.078 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp35_label")
     2.081 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp36_crit_alarm")
     2.083 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp26_crit")
     2.084 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp40_input")
     2.085 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp40_crit_alarm")
     2.087 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp43_crit")
     2.088 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp45_label")
     2.092 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp14_crit")
     2.093 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp34_input")
     2.094 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp45_crit_alarm")
     2.096 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp35_max")
     2.097 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp18_input")
     2.099 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp10_max")
     2.100 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp39_label")
     2.103 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp22_label")
     2.106 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp6_crit")
     2.108 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp39_max")
     2.109 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp44_input")
     2.111 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp14_max")
     2.112 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp37_crit")
     2.114 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp42_max")
     2.115 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp2_label")
     2.123 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp18_max")
     2.124 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp38_input")
     2.125 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp34_crit_alarm")
     2.127 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp42_crit")
     2.128 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp42_label")
     2.131 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp26_label")
     2.134 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp14_crit_alarm")
     2.136 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp39_crit_alarm")
     2.137 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp30_crit")
     2.138 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_input")
     2.140 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_crit_alarm")
     2.141 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp43_crit_alarm")
     2.143 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp36_label")
     2.146 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp6_label")
     2.149 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp36_crit")
     2.151 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp41_input")
     2.152 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp6_crit_alarm")
     2.153 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp36_max")
     2.155 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp35_input")
     2.156 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp41_crit")
     2.158 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp45_input")
     2.159 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp43_max")
     2.160 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp37_crit_alarm")
     2.162 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp18_crit")
     2.163 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp41_crit_alarm")
     2.165 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp35_crit")
     2.166 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp22_max")
     2.168 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp39_input")
     2.169 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp22_input")
     2.170 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_max")
     2.172 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp43_label")
     2.175 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp26_max")
     2.177 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp10_label")
     2.180 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp40_crit")
     2.181 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="name")
     2.183 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp26_crit_alarm")
     2.184 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp2_input")
     2.186 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp37_label")
     2.189 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp30_crit_alarm")
     2.191 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_34")
     2.192 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_34")
     2.194 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_39")
     2.195 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_39")
     2.197 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_36")
     2.198 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_36")
     2.199 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_28")
     2.201 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_28")
     2.202 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_41")
     2.203 perf/147400 event syntax error: 'temp_test_hwmon_event1'
probe_perf:hwmon_pmu__have_event_L25(                     \___ Bad event name
(6612ef) name="temp_core_41"
Unable to find event on a PMU of 'temp_test_hwmon_event1'
)
     2.205 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_package_id_0")
     2.206 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_package_id_0")
     2.208 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_20")
     2.209 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_20")
     2.210 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_33")
     2.212 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_33")
     2.213 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_12")
     2.215 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_12")
     2.216 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_4")
     2.217 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_4")
     2.219 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_38")
     2.220 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_38")
     2.221 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_43")
     2.223 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_43")
     2.224 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_35")
     2.226 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_35")
     2.227 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_40")
     2.228 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_40")
     2.230 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_32")
     2.231 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_32")
     2.233 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_24")
     2.234 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_24")
     2.235 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_37")
     2.237 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_37")
     2.238 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_16")
     2.239 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_16")
     2.241 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_8")
     2.242 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_8")
     2.244 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_42")
     2.245 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_42")
     2.246 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_core_0")
     2.248 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_core_0")
     2.249 perf/147400 probe_perf:hwmon_pmu__have_event_L29((66135d))
     2.251 perf/147400 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     2.252 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     2.256 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="uevent")
     2.258 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp6_input")
     2.259 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp3_input")
     2.261 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp4_input")
     2.262 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_input")
     2.264 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp5_input")
     2.265 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="name")
     2.267 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp2_input")
     2.269 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="")
     2.270 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="")
     2.272 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="")
     2.273 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="")
     2.275 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="")
     2.277 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="")
     2.278 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="")
     2.280 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="")
     2.281 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="")
     2.283 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="")
     2.285 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="")
     2.286 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="")
     2.287 perf/147400 probe_perf:hwmon_pmu__have_event_L29((66135d))
     2.289 perf/147400 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     2.290 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     2.294 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="uevent")
     2.295 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_label")
     2.299 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_crit")
     2.301 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_alarm")
     2.302 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_input")
     2.303 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_min")
     2.305 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_max")
     2.306 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="name")
     2.308 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="temp_composite")
     2.309 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="temp_composite")
     2.311 perf/147400 probe_perf:hwmon_pmu__have_event_L29((66135d))
     2.312 perf/147400 probe_perf:hwmon_pmu__have_event((6611f1) name_string="temp_test_hwmon_event1")
     2.313 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     2.317 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="uevent")
     2.319 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_lcrit_alarm")
     2.320 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_enable")
     2.322 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_crit")
     2.323 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_lcrit")
     2.325 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_min_alarm")
     2.326 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_input")
     2.328 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_crit_alarm")
     2.329 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_min")
     2.331 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_max_alarm")
     2.332 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp1_max")
     2.334 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="name")
     2.335 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612e8) name="")
     2.337 perf/147400 probe_perf:hwmon_pmu__have_event_L25((6612ef) name="")
     2.338 perf/147400 probe_perf:hwmon_pmu__have_event_L29((66135d))
 11.2: Parsing without PMU name                                      : FAILED!
     6.499 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     6.517 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     6.526 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     6.530 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="temp_test_hwmon_event1")
     6.596 perf/147400 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     6.599 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="hwmon_a_test_hwmon_pmu")
     6.602 perf/147400 probe_perf:hwmon_pmu__have_event_L10((66123e))
     6.606 perf/147400 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     6.609 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="hwmon_a_test_hwmon_pmu")
     6.612 perf/147400 probe_perf:hwmon_pmu__have_event_L10((66123e))
     6.615 perf/147400 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     6.618 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="hwmon_a_test_hwmon_pmu")
     6.621 perf/147400 probe_perf:hwmon_pmu__have_event_L10((66123e))
     6.624 perf/147400 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     6.627 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="hwmon_a_test_hwmon_pmu")
     6.630 perf/147400 probe_perf:hwmon_pmu__have_event_L10((66123e))
     6.633 perf/147400 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     6.636 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="hwmon_a_test_hwmon_pmu")
     6.638 perf/147400 probe_perf:hwmon_pmu__have_event_L10((66123e))
event syntax error: 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
                     \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'hwmon_a_test_hwmon_pmu'
     6.895 perf/147400 probe_perf:hwmon_pmu__have_event((6611f1) name_string="hwmon_a_test_hwmon_pmu")
     6.900 perf/147400 probe_perf:parse_hwmon_filename((65fd14) filename_string="hwmon_a_test_hwmon_pmu")
     6.904 perf/147400 probe_perf:hwmon_pmu__have_event_L10((66123e))
 11.3: Parsing with PMU name                                         : FAILED!
root@number:~# 

And before the hashmap__find() at line 17:

>      15         key.type = type;
>      16         key.num = number;
>      17         if (hashmap_find(&hwm->events, key.type_and_num, /*value=*/NULL))
>      18                 return true;


root@number:~# perf probe -x ~/bin/perf hwmon_pmu__have_event:17 type number
Added new events:
  probe_perf:hwmon_pmu__have_event_L17 (on hwmon_pmu__have_event:17 in /home/acme/bin/perf with type number)
  probe_perf:hwmon_pmu__have_event_L17 (on hwmon_pmu__have_event:17 in /home/acme/bin/perf with type number)
  probe_perf:hwmon_pmu__have_event_L17 (on hwmon_pmu__have_event:17 in /home/acme/bin/perf with type number)
  probe_perf:hwmon_pmu__have_event_L17 (on hwmon_pmu__have_event:17 in /home/acme/bin/perf with type number)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:hwmon_pmu__have_event_L17 -aR sleep 1

root@number:~#

root@number:~# perf trace --libtrace -e probe_perf:hwmon_pmu__have_event_L17 perf test -F 11
 11.1: Basic parsing test                                            : Ok
     0.000 :147579/147579 probe_perf:hwmon_pmu__have_event_L17((66126f) type=0xa number=-1)
     0.011 :147579/147579 probe_perf:hwmon_pmu__have_event_L17((661273) type=0xa number=-1)
     0.013 :147579/147579 probe_perf:hwmon_pmu__have_event_L17((66127e) type=0xa number=-1)
     0.015 :147579/147579 probe_perf:hwmon_pmu__have_event_L17((66128e) type=0xa number=-1)
     0.021 :147579/147579 probe_perf:hwmon_pmu__have_event_L17((66126f) type=0xa number=-1)
     0.022 :147579/147579 probe_perf:hwmon_pmu__have_event_L17((661273) type=0xa number=-1)
     0.023 :147579/147579 probe_perf:hwmon_pmu__have_event_L17((66127e) type=0xa number=-1)
     0.024 :147579/147579 probe_perf:hwmon_pmu__have_event_L17((66128e) type=0xa number=-1)
event syntax error: 'temp_test_hwmon_event1'
                     \___ Bad event name

Unable to find event on a PMU of 'temp_test_hwmon_event1'
     0.160 perf/147579 probe_perf:hwmon_pmu__have_event_L17((66126f) type=0xa number=-1)
     0.162 perf/147579 probe_perf:hwmon_pmu__have_event_L17((661273) type=0xa number=-1)
     0.163 perf/147579 probe_perf:hwmon_pmu__have_event_L17((66127e) type=0xa number=-1)
     0.165 perf/147579 probe_perf:hwmon_pmu__have_event_L17((66128e) type=0xa number=-1)
     0.172 perf/147579 probe_perf:hwmon_pmu__have_event_L17((66126f) type=0xa number=-1)
     0.173 perf/147579 probe_perf:hwmon_pmu__have_event_L17((661273) type=0xa number=-1)
     0.174 perf/147579 probe_perf:hwmon_pmu__have_event_L17((66127e) type=0xa number=-1)
     0.175 perf/147579 probe_perf:hwmon_pmu__have_event_L17((66128e) type=0xa number=-1)
     0.185 perf/147579 probe_perf:hwmon_pmu__have_event_L17((66126f) type=0xa number=-1)
     0.186 perf/147579 probe_perf:hwmon_pmu__have_event_L17((661273) type=0xa number=-1)
     0.187 perf/147579 probe_perf:hwmon_pmu__have_event_L17((66127e) type=0xa number=-1)
     0.189 perf/147579 probe_perf:hwmon_pmu__have_event_L17((66128e) type=0xa number=-1)
     0.213 perf/147579 probe_perf:hwmon_pmu__have_event_L17((66126f) type=0xa number=-1)
     0.214 perf/147579 probe_perf:hwmon_pmu__have_event_L17((661273) type=0xa number=-1)
     0.216 perf/147579 probe_perf:hwmon_pmu__have_event_L17((66127e) type=0xa number=-1)
     0.217 perf/147579 probe_perf:hwmon_pmu__have_event_L17((66128e) type=0xa number=-1)
 11.2: Parsing without PMU name                                      : FAILED!
event syntax error: 'hwmon_a_test_hwmon_pmu/temp_test_hwmon_event1/'
                     \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'hwmon_a_test_hwmon_pmu'
 11.3: Parsing with PMU name                                         : FAILED!
root@number:~#

- Arnaldo
