Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBFA19ABCB
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771506; cv=none; b=kdtRJjI529CNVqzxbXS98qVqREuc/jQ23OTyFNBiwvTcwjJOE4/mYiKkDRnoadP/OtQZBxRjwC47d2yvSlhvRTgyyd00fCnWc4ZyYW7nEhgRXiOosTDZT47YAvOVZ1hqP2WfXAX5u86ZK6yqxa43uATY2CEeubWy/H9MXcKyBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771506; c=relaxed/simple;
	bh=TlZVzME4pG/XDIV/hEeXgpkK3uqlwh/Td+lszGuxblk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D2XpSmjWywS8ll6gncHcjcyQY+Z5SqH0lML1X9ySWh/2BNdJrW37+Wec8GC8OPSdmWz8LHAKi7SyzcViT8ypkqW0Ee/sA5o8EwAWNewBUGnE6lvLLw+2UlqreO67TzU3eueNSt6pJ9nqIdNtSx2Z4RpmjCNOgiHShryMyakzcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+QGhY8E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+QGhY8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727771503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6zXPnNsOXUbMY9+FnPXYlqVDe76ENHWyxpiBYvE+ts=;
	b=b+QGhY8EUhskQMxvIW9iq7xSJTmT2J5sSjWxQemjs0WQiXbbRnxkmhZA3KEKZRSaRCAmmw
	HNlRpNWpQxSwj6IRj7nSPYUauJSuEDIiJMeRRD+YXXZtKx5W+V0Njom5cu/a+q340BuXGI
	NHfWwoh1iz0ch2L2U69sdebU0OGcUnE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-O0I-yHf8O0ePxCPe1yGFPg-1; Tue, 01 Oct 2024 04:31:42 -0400
X-MC-Unique: O0I-yHf8O0ePxCPe1yGFPg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53987fc3625so2787476e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 01:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727771500; x=1728376300;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6zXPnNsOXUbMY9+FnPXYlqVDe76ENHWyxpiBYvE+ts=;
        b=rjcdYDx1CB/oiqXGghbQvClGyxdes/neXGnE2HGGuOx83cr5w8820CQoc17575eDAC
         iaBx+oac7vHBscPeGge72grPNDY6XtPISL828KMLQS7LQ+y4BzT2iLunWbQI6mzR5o0m
         M0fKhp9yYXZR7qd0CN+hEqdskVQpScDeXQM0dd9hjmYWycICCXwV5VZs6cP/1Np79BZx
         wnnUTpDb362z7AWjbUVoXb8mSU34Gcdb+60V6h3dwFXXV6tn/bo9IUaYRUTx8JmyIiLp
         KUUNHZbDl0n9trG3QydKgLJVuJn3ADK3OncavvYL8X/dzL8/S0mirJw98dn/AwKNQplo
         Hhlg==
X-Gm-Message-State: AOJu0Yx1js0egH/1abuv+ORJZb6skdWQ0oadTkzyWuDKlkXxHne9GADY
	OxjgxiNRf+IzuZcL2F7iuC2aSXIjcbLAFKbRDz/t6bXtv+HT768Tarr4lJrY1IU2xLiQKiuUosl
	/cXMHE5v0WhOprqb1JsnSn3PeeMqW5c4ziEZODq6NF2Tn+6fqmSJxt+bZzI6OdR0tYW8/mGdIIE
	xrxXm35KQ6yfNrlyMmUq2Ag2jGXYkb3AMBchfyJJfgtzBiteVAse3y8Q==
X-Received: by 2002:a05:6512:2305:b0:535:6b9e:bcdd with SMTP id 2adb3069b0e04-5389fc4b764mr8821042e87.33.1727771500115;
        Tue, 01 Oct 2024 01:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfAwMe/4G1ev9ZSlBmq2jA38EkvfS/3mTDMdRPe4zgDH4FcNVGeRmySNSgsQN+2QOXJxeJMQ==
X-Received: by 2002:a05:6512:2305:b0:535:6b9e:bcdd with SMTP id 2adb3069b0e04-5389fc4b764mr8821016e87.33.1727771499636;
        Tue, 01 Oct 2024 01:31:39 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec11bsm128627155e9.23.2024.10.01.01.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 01:31:39 -0700 (PDT)
Message-ID: <8664c3ee-01ff-4c96-bce7-54b22dc1a5e0@redhat.com>
Date: Tue, 1 Oct 2024 10:31:38 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Restore sample rate for perf_event_attr
From: Veronika Molnarova <vmolnaro@redhat.com>
To: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Cc: mpetlan@redhat.com, rstoyano@redhat.com, mark.rutland@arm.com,
 kan.liang@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
References: <20240828134655.29267-1-vmolnaro@redhat.com>
Content-Language: en-US
In-Reply-To: <20240828134655.29267-1-vmolnaro@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ping

On 8/28/24 15:46, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Test "Setup struct perf_event_attr" consists of multiple test cases that
> can affect the max sample rate value for perf events. Some test cases
> check this value as it should not be lowered under the set minimum for
> the given test. Currently, it is possible for the test cases to affect
> each other as the previous tests can lower the sample rate, leading to
> a possible failure of some of the future test cases as the value is not
> restored at any point.
> 
>  10: Setup struct perf_event_attr:
> --- start ---
> test child forked, pid 104220
> Using CPUID 0x00000000413fd0c1
> running './tests/attr/test-record-C0'
> Current sample rate: 10000
> running './tests/attr/test-record-basic'
> Current sample rate: 900
> running './tests/attr/test-record-branch-any'
> Current sample rate: 600
> running './tests/attr/test-record-dummy-C0'
> Current sample rate: 600
> expected sample_period=4000, got 600
> FAILED './tests/attr/test-record-dummy-C0' - match failure
> 
> Restore the max sample rate value for perf events to a reasonable value
> before each test case if its value was lowered too much to ensure the
> same conditions for each test case.
> 
>  10: Setup struct perf_event_attr:
> --- start ---
> test child forked, pid 107222
> Using CPUID 0x00000000413fd0c1
> running './tests/attr/test-record-C0'
> Current sample rate: 10000
> running './tests/attr/test-record-basic'
> Current sample rate: 800
> running './tests/attr/test-record-branch-any'
> Current sample rate: 700
> unsupp  './tests/attr/test-record-branch-any'
> running './tests/attr/test-record-branch-filter-any'
> Current sample rate: 10000
> running './tests/attr/test-record-count'
> Current sample rate: 10000
> running './tests/attr/test-record-data'
> Current sample rate: 600
> running './tests/attr/test-record-dummy-C0'
> Current sample rate: 800
> running './tests/attr/test-record-freq'
> Current sample rate: 10000
> ...
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Radostin Stoyanov <rstoyano@redhat.com>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> ---
>  tools/perf/tests/attr.py | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
> index e890c261ad26..3db9a7d78715 100644
> --- a/tools/perf/tests/attr.py
> +++ b/tools/perf/tests/attr.py
> @@ -246,6 +246,23 @@ class Test(object):
>                  return False
>          return True
>  
> +    def restore_sample_rate(self, value=10000):
> +        try:
> +            # Check value of sample_rate
> +            with open("/proc/sys/kernel/perf_event_max_sample_rate", "r") as fIn:
> +                curr_value = fIn.readline()
> +            # If too low restore to reasonable value
> +            if not curr_value or int(curr_value) < int(value):
> +                with open("/proc/sys/kernel/perf_event_max_sample_rate", "w") as fOut:
> +                    fOut.write(str(value))
> +
> +        except IOError as e:
> +            log.warning("couldn't restore sample_rate value: I/O error %s" % e)
> +        except ValueError as e:
> +            log.warning("couldn't restore sample_rate value: Value error %s" % e)
> +        except TypeError as e:
> +            log.warning("couldn't restore sample_rate value: Type error %s" % e)
> +
>      def load_events(self, path, events):
>          parser_event = configparser.ConfigParser()
>          parser_event.read(path)
> @@ -283,6 +300,7 @@ class Test(object):
>          if self.skip_test_kernel_until():
>              raise Notest(self, "new kernel skip")
>  
> +        self.restore_sample_rate()
>          cmd = "PERF_TEST_ATTR=%s %s %s -o %s/perf.data %s" % (tempdir,
>                self.perf, self.command, tempdir, self.args)
>          ret = os.WEXITSTATUS(os.system(cmd))

