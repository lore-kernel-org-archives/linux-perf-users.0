Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFAE148823
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Oct 2024 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960189; cv=none; b=GglqqAWT1oyLpzRoCPsEbvnKKAdosvu4vAKDpZwO+zv97mCc/C249vh2dmKVpQwdZb7KdsgGbKViJJWjoQaeBfLjJAeIetto8EmXewOvbPUHTFx0sKpbgGoTHQbNDlHWHadA1Azk2o61SMQjvyrb0yLQbQNGNkWiaE4BY5utrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960189; c=relaxed/simple;
	bh=c8QhWe2lODUyA5afdWQX1KtHq5tZ+5iStsMhRfeBLPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IP242oJEuknH7+NfsfJktZmiHZBmle7PE2xH7RrENuTym8pz9ufJCCfGtSYXtpSlCTPumCAOUDr55APJlqyrAgDZhFfs0CY/1KPnl5EMWgCHbSPnRwUuEMzU9ZBUHTKc9p1sqKqlnd9sWfYFLvWJaMPQM+qzzEPTpjRBYm7bHwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XadbY29B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XadbY29B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727960186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fZAeVOYKuUBjtlgJxbXNlpsVLkuwRcY6rwOzqM8bX8g=;
	b=XadbY29BNc8+4jJCYVj0+RiW2vsmQkoK4qKB634xc7Fztotr/tBmWYW5On8ib1yHE74teY
	F/894HO9f3xJ7QjNJyRDPjNmiM8AtrwR+QvdWSwADtTtM0FptNMRKG7O1ZSWUMMjxyPWNu
	1gK/pDJW4OLY/nOAyDpRLfgnQR5jWCM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-MbdWOveNOyScG-PU6JJnvA-1; Thu, 03 Oct 2024 08:56:25 -0400
X-MC-Unique: MbdWOveNOyScG-PU6JJnvA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37cd1fb9497so1016435f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Oct 2024 05:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727960184; x=1728564984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZAeVOYKuUBjtlgJxbXNlpsVLkuwRcY6rwOzqM8bX8g=;
        b=Fwjd3UjZaL7GzDtMj3wid3LJQRLpP8ldQcMVljCOqHSMh6a2yIzH1UtkrmdHYKEQbV
         MsGv/NGOH9YVUIBb85xPui9i03doj8KyrdCm9OHFdgg22sIcq6xXqVuTuxNCtRWB6kK5
         TP8P1z/bnOHUuwtD3LXpHgih0ZMySulLELcTLnLyJpYsVkbp93NMZuEJgV3GrfMSozP4
         CxV9XI6VEF8IBb0RIZRYk/GUw4xgCBXLFKA3ZWg33+DMDlqAI9/TMr2dbBEgOKnopUOf
         JlrCJGiFd4vqQpPW4O/TQHbpyn/ugwQ2ea2vs+jSLCwi7GlcrWij0CvOqFgeQY70arV6
         GojQ==
X-Gm-Message-State: AOJu0YyUfQrT2+5K5bdAmY4Qa0hs67aoKfjwNif+cynmoCxGWeXiAusm
	EUKykl975D1QH67V1MGYKS9aK2MQtv6vSBFX2SdplPJLRV/7RYAufCR9xMSNFBDXgaqPaUoNWZ+
	ww/Fmq10NLnAQxK7lWYoFHkQCmWYMHqszfZ007HUD6SGsjxyOTAIb7DeCQHQP2b7EzyE=
X-Received: by 2002:a05:6000:2d01:b0:37c:ccba:8c93 with SMTP id ffacd0b85a97d-37d049e542dmr2075141f8f.11.1727960184449;
        Thu, 03 Oct 2024 05:56:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1fX4tRbzni74RrcrkjYdb9mz+9w8/IhySpDdfgdAbMQCVaC3Rl29TCrULGRAl04cI/ScWoA==
X-Received: by 2002:a05:6000:2d01:b0:37c:ccba:8c93 with SMTP id ffacd0b85a97d-37d049e542dmr2075108f8f.11.1727960184013;
        Thu, 03 Oct 2024 05:56:24 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f80255f01sm15165335e9.9.2024.10.03.05.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 05:56:23 -0700 (PDT)
Message-ID: <c54aeb31-30f0-4169-94b8-0804f6f7989b@redhat.com>
Date: Thu, 3 Oct 2024 14:56:22 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Restore sample rate for perf_event_attr
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
 mpetlan@redhat.com, rstoyano@redhat.com, mark.rutland@arm.com,
 kan.liang@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
References: <20240828134655.29267-1-vmolnaro@redhat.com>
 <8664c3ee-01ff-4c96-bce7-54b22dc1a5e0@redhat.com>
 <ZvyRefEz4lj4evm5@google.com>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <ZvyRefEz4lj4evm5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/2/24 02:19, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Oct 01, 2024 at 10:31:38AM +0200, Veronika Molnarova wrote:
>> Ping
>>
>> On 8/28/24 15:46, vmolnaro@redhat.com wrote:
>>> From: Veronika Molnarova <vmolnaro@redhat.com>
>>>
>>> Test "Setup struct perf_event_attr" consists of multiple test cases that
>>> can affect the max sample rate value for perf events. Some test cases
>>> check this value as it should not be lowered under the set minimum for
>>> the given test. Currently, it is possible for the test cases to affect
>>> each other as the previous tests can lower the sample rate, leading to
>>> a possible failure of some of the future test cases as the value is not
>>> restored at any point.
>>>
>>>  10: Setup struct perf_event_attr:
>>> --- start ---
>>> test child forked, pid 104220
>>> Using CPUID 0x00000000413fd0c1
>>> running './tests/attr/test-record-C0'
>>> Current sample rate: 10000
>>> running './tests/attr/test-record-basic'
>>> Current sample rate: 900
>>> running './tests/attr/test-record-branch-any'
>>> Current sample rate: 600
>>> running './tests/attr/test-record-dummy-C0'
>>> Current sample rate: 600
>>> expected sample_period=4000, got 600
>>> FAILED './tests/attr/test-record-dummy-C0' - match failure
> 
> Please indent the shell output or source code by at least 2 spaces so
> that git can distinguish it from other messages.  Typical problems are
> having '#' at the beginning of a line.
> 
> In this case, '---' in the test output makes it think the rest is a
> comment and ignored the messages.
> 
> Can you please resend with the change?

Thanks for letting me know, will resend the patch.

Thanks,
Veronika
> 
> Thanks,
> Namhyung
> 
>>>
>>> Restore the max sample rate value for perf events to a reasonable value
>>> before each test case if its value was lowered too much to ensure the
>>> same conditions for each test case.
>>>
>>>  10: Setup struct perf_event_attr:
>>> --- start ---
>>> test child forked, pid 107222
>>> Using CPUID 0x00000000413fd0c1
>>> running './tests/attr/test-record-C0'
>>> Current sample rate: 10000
>>> running './tests/attr/test-record-basic'
>>> Current sample rate: 800
>>> running './tests/attr/test-record-branch-any'
>>> Current sample rate: 700
>>> unsupp  './tests/attr/test-record-branch-any'
>>> running './tests/attr/test-record-branch-filter-any'
>>> Current sample rate: 10000
>>> running './tests/attr/test-record-count'
>>> Current sample rate: 10000
>>> running './tests/attr/test-record-data'
>>> Current sample rate: 600
>>> running './tests/attr/test-record-dummy-C0'
>>> Current sample rate: 800
>>> running './tests/attr/test-record-freq'
>>> Current sample rate: 10000
>>> ...
>>>
>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>> Cc: Ian Rogers <irogers@google.com>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Cc: Kan Liang <kan.liang@linux.intel.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Michael Petlan <mpetlan@redhat.com>
>>> Cc: Radostin Stoyanov <rstoyano@redhat.com>
>>> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>>> ---
>>>  tools/perf/tests/attr.py | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
>>> index e890c261ad26..3db9a7d78715 100644
>>> --- a/tools/perf/tests/attr.py
>>> +++ b/tools/perf/tests/attr.py
>>> @@ -246,6 +246,23 @@ class Test(object):
>>>                  return False
>>>          return True
>>>  
>>> +    def restore_sample_rate(self, value=10000):
>>> +        try:
>>> +            # Check value of sample_rate
>>> +            with open("/proc/sys/kernel/perf_event_max_sample_rate", "r") as fIn:
>>> +                curr_value = fIn.readline()
>>> +            # If too low restore to reasonable value
>>> +            if not curr_value or int(curr_value) < int(value):
>>> +                with open("/proc/sys/kernel/perf_event_max_sample_rate", "w") as fOut:
>>> +                    fOut.write(str(value))
>>> +
>>> +        except IOError as e:
>>> +            log.warning("couldn't restore sample_rate value: I/O error %s" % e)
>>> +        except ValueError as e:
>>> +            log.warning("couldn't restore sample_rate value: Value error %s" % e)
>>> +        except TypeError as e:
>>> +            log.warning("couldn't restore sample_rate value: Type error %s" % e)
>>> +
>>>      def load_events(self, path, events):
>>>          parser_event = configparser.ConfigParser()
>>>          parser_event.read(path)
>>> @@ -283,6 +300,7 @@ class Test(object):
>>>          if self.skip_test_kernel_until():
>>>              raise Notest(self, "new kernel skip")
>>>  
>>> +        self.restore_sample_rate()
>>>          cmd = "PERF_TEST_ATTR=%s %s %s -o %s/perf.data %s" % (tempdir,
>>>                self.perf, self.command, tempdir, self.args)
>>>          ret = os.WEXITSTATUS(os.system(cmd))
>>
> 

