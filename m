Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD902EEE85
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047480; cv=none; b=Ua61sTP3iIFQA0WoV5CgmEaI0gkrqkqiJOMKyjruUuRnVgxi+882lgsXgXdakCGD3zGQbCC0Oio2W3SdSAkLNj9PsKwM+AyLzL0kW459fALycZ8zRdF7Rtfw6sBggDTtDrpCS5u2RO62aKEIR8QDfXBIShZcqe4FpdpQ+Gs4UTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047480; c=relaxed/simple;
	bh=VlPPQHp/MYTzELak8+O+u2gluyrthPViFM78wGV0AEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/qY/D3rsvXAALIUFxZuHt6zUv8G+gIbnYcWn9lyGH60aNPvyYbGhGdmpMfvF8k4Sl4VxFrXu+0SGmnkLvMHSpkDXs0ONmyGkIlpZ1kq7OTn7gmOYnLTwNcycCJ2YHvRUjao4pNCrhIkmN0/uj8zQwTR1Daat6OEmV1gJoG2nnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VZ0oI9za; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZ0oI9za"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-499a4d1d7f1so3462125e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787047476; x=1787652276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FsFa9e1COyIPBcpmydRj4KWmYb2/dMT6GIMQOmAVfjI=;
        b=VZ0oI9zaQ6ntwQX7ug/Jk2zwlt+H8UjFD7ahp7qKgnXQgt5M6Ledai+bBVkjI4lApT
         olSWG1tx39T8urBUcyXC1/wN3HAVG9THIL1TZZItaVm3X8bWsugh25Y9TR/OoIi4tfd2
         ASjdPUtMwLxFmwBq9WbofWkNafl/Cc62LcHRiHxkLQ9loUkrEqskXmJIFFrLfWuRh6pV
         Op1yMWmofQzRtzFXu1+mirDEtgQ1LAnXIszFUwNuxuMAMugHzr3N+cNYaAyXuuljddbx
         EOaUrK0GTaVWi3c5Wn0Kngw379a6K8kDi+HbOfXT170V1y5YqMow93hGQEYOpUauijFh
         E4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787047476; x=1787652276;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FsFa9e1COyIPBcpmydRj4KWmYb2/dMT6GIMQOmAVfjI=;
        b=mzSqVuvpNegVNaojSk/a90o893Z7cnk8/qRtfdDnS43TkpXlh1ekQlDLv+rYD/4wBI
         LVnDtkn5gV5TyvbYBBF2HO4MPJfT6W2j6iQBcIkItJF4V+9jgxqEGg2pgbnC1SLn3bRC
         FXf/XCPG2Q59yJ7NSBxDXT8IfBvNiIg6LceTB7IoQdUOJayjpus+9+I9O+8nBYy/uMTM
         +M6kEfkF6KfVRkUVAzmBdlBPYP0Oto3Suf2njWXOhjkjHQKNea4kCpAX8VrpwmCMvQNo
         tLbziTqniI9TUcAcRjEJsXV3ttbmmAA8C2Px7dHSWJe+tnr5U8ukdevRzPPHMHOGRRUz
         b0lw==
X-Forwarded-Encrypted: i=1; AHgh+RqXAyQFflZ1nm3oumZr217DSY0hrF6q3X+ZDkBE7XAiFkdvVR3hePl3ppkYG3zi+esl5AkFZ1BJ79jXCmDcVqLg@vger.kernel.org
X-Gm-Message-State: AOJu0YzisGxcHTYfDT60XODUwJhFj4+HVxVldWYkVehHW6EUJXCeNXSL
	w0T63j1xAa6uj9mfgWZI/3PCiJsLw5gPLN+bA0CH3C9P0frD4a/HRxRxuyIHUCHzTNY=
X-Gm-Gg: AR+sD12vaoeYv9jPEVtd7brS6uIeAq+bYpUObS0DGPvOVtq/yg4mAT+Y7jvR9sHi4TB
	B8ncqX5CMp+x3bHdgmfl9QQ2+du4aUKu4AOeJaAS8DdQ2HvZEJhcA8KFgVrn4XhZpOYX+jV+5cD
	+1xuMV2e/LswH1PrnCiq1LEZPlVnot5QTAjNh1ZbUiH/PdA2OB+TG7fKy1ilN+USdGMoqQBetIX
	MNp5tyRsmwpbhC2/Snqo1C2i7X4WXaMePioT+z3ccK7Md6/mUGK0ALeE/gXhHeqXHzHV3Rdpewx
	Hj70iPaSx8lx3Oh08O5c5oE8FFQmOoGpBu1ROYT+hbn0HlRaOwv3i7ZEwHVhpkvVYfj2I7v7qD2
	wF8dYpphd9GZZ0g20aFZTqiCntTt6ubgKPXY0FhvETvd6TRg5Bh6n4F4aLAk2jjNx4lobIC6903
	oC3zPJ/hKjuWel2FuLMuvA7V2vw+4GYzkB93jtrrgDWQZ3ri15iBJ3TI7rDOZgF9JDyD5i8F32R
	AoO
X-Received: by 2002:a05:600c:3f10:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-4999fb3c2d6mr130200395e9.12.1787047475965;
        Tue, 18 Aug 2026 03:04:35 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b783c6sm11439647f8f.31.2026.08.18.03.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 03:04:35 -0700 (PDT)
Message-ID: <066f843e-0b87-4860-bb8c-c6714a5f57c8@linaro.org>
Date: Tue, 18 Aug 2026 11:04:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] perf tests: mmap-basic: fix user rdpmc detection logic
To: Ian Rogers <irogers@google.com>
Cc: Michael Petlan <mpetlan@redhat.com>, Qiao Zhao <qzhao@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20260817-rdpmc-detection-logic-v4-1-c22074578f6a@linaro.org>
 <CAP-5=fWw6-NsAOjSUSNFgnA0vNg1pbE=Yf=QwF54y97WTdjXyQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fWw6-NsAOjSUSNFgnA0vNg1pbE=Yf=QwF54y97WTdjXyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/08/2026 20:13, Ian Rogers wrote:
> On Mon, Aug 17, 2026 at 8:54 AM James Clark <james.clark@linaro.org> wrote:
>>
>> From: Qiao Zhao <qzhao@redhat.com>
>>
>> RISC-V and Arm control userspace counter access through
>> /proc/sys/kernel/perf_user_access. Add that as a fallback to
>> set_user_read() so the test can test both the enabled and disabled
>> states on those platforms. RISC-V also uses a '2' value rather than just
>> 0 or 1 so add support for restoring arbitrary values.
>>
>> On Arm, cap_user_rdpmc will always be set when requested, even if the
>> global setting is disabled. This is so that the feature can be enabled
>> or revoked while events are live. Skip checking it on Arm for the
>> "expected disabled" case, otherwise the test will fail.
>>
>> Add comments, more meaningful variable names and improve the error
>> messages so that it's clearer what this part of the test is doing.
>>
>> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
>> [Test pc->index, fix bugs in set_user_read(), and simplify commit msg]
>> Assisted-by: Codex:GPT-5.6
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> I'm sending this to fix the comments that I left on the "V3 resend"
>> because I don't think Qiao sent a V4 and it's been quite a while.
>>
>> There were also some unreported bugs that I found during testing.
>>
>> Changes in V4:
>>   - Don't remove pc->index check. Without it Perf can silently fall back
>>     to the read() syscall and the test is useless.
>>   - Test the 'expected disabled' case for Arm in an ifdef to workaround
>>     platform differences.
>>   - lseek() before writing to perf_user_access otherwise it's ignored.
>>   - Support restoring arbitrary values to perf_user_access because RISC-V
>>     uses '2' for legacy mode.
> 
> What does that mean? Should there be corresponding "legacy" support in libperf?
> 

I don't think so, it looks like more of a security thing and 'legacy' 
isn't really supposed to be used. It was only added in case someone 
wants to go back to the original insecure behavior:

   "We used to unconditionnally expose the cycle and instret csrs to
    userspace, which gives rise to security concerns. So now we only
    allow access to hw counters from userspace through the perf
    framework which will handle context switches, per-task events...etc.
    A sysctl allows to revert the behaviour to the legacy mode so that
    userspace applications which are not ready for this change do not
    break."

   drivers/perf/riscv_pmu_sbi.c:

   #define SYSCTL_NO_USER_ACCESS	0
   #define SYSCTL_USER_ACCESS	1
   #define SYSCTL_LEGACY		2

I added this so that the test doesn't overwrite an existing legacy value 
and then not restore it which could break their system after running the 
Perf tests.

>>   - Rename rdpmc_supported to rdpmc_expected as this is what the test
>>     expects, not what the system does.
> 
> Can you explain the distinction here? The test expects that if
> userspace reading is enabled, it should be supported. Imo this makes a
> line like:
> ```
> if (rdpmc_supported && counts.val == 0) {
> ```
> easy to read. The same line with rdpmc_expected, well I need to then
> go and figure out what expected should mean and it seems to just mean

rdpmc_supported was already defined somewhere else, I only renamed it so 
I'm not sure having to go and figure anything out is a strong argument.

> supported, so the code was more readable before.
> 

I don't think it does mean supported, the default case is this one:

   rdpmc_expected = (enabled == USER_READ_ENABLED);

That's not whether the system supports it or has enabled it or not, it's 
what the test attempted to write into sysfs and what is expected for 
that invocation of the function. The system might not actually support 
it or have enabled it, and in that case the test should fail because 
expected != active. If writing into the sysfs file was silently not 
accepted then you can't assume enabled == supported (unless you read 
back the file which the test doesn't do, it just blindly writes and then 
assumes it worked, i.e. "expects").

I was trying to separate the concepts of what the system has done vs 
what the test expects. I thought "expected" is quite a common term in 
testing for test derived variables, but it's just a variable name so I'm 
not too set on it, but I do think it's an improvement.

>>   - Label pc->index as rdpmc_event_active for clarity.
>>   - Add comments and simplify the commit message.
>> ---
>>   tools/perf/tests/mmap-basic.c | 137 ++++++++++++++++++++++++++++++------------
>>   1 file changed, 98 insertions(+), 39 deletions(-)
>>
>> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
>> index 5cec7644952c..4433a5df3d77 100644
>> --- a/tools/perf/tests/mmap-basic.c
>> +++ b/tools/perf/tests/mmap-basic.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   #include <errno.h>
>>   #include <inttypes.h>
>> +#include <limits.h>
>>   #include <stdlib.h>
>>
>>   #include <fcntl.h>
>> @@ -182,47 +183,77 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
>>   }
>>
>>   enum user_read_state {
>> -       USER_READ_ENABLED,
>> -       USER_READ_DISABLED,
>> -       USER_READ_UNKNOWN,
>> +       USER_READ_UNKNOWN = -1,
>> +       USER_READ_DISABLED = 0,
>> +       USER_READ_ENABLED = 1,
>>   };
>>
>> -static enum user_read_state set_user_read(struct perf_pmu *pmu, enum user_read_state enabled)
>> +static int set_user_read_fd(int fd, int enabled)
> 
> Why change this to an int rather than adding "legacy" to the
> user_read_state enum? An int gives far more potential values than the
> enum and so appears inherently less intention-revealing.
> 

I did consider it but I didn't think it was very future proof. This 
would then break a system when someone adds a 3. If we weren't restoring 
whatever value is read then I would agree just using the enum would make 
sense, but I think it should handle any integer. Wouldn't this just 
trade functionality for style?

>>   {
>> -       char buf[2] = {0, '\n'};
>> +       char buf[32], *endptr;
>> +       long value;
>>          ssize_t len;
>> -       int events_fd, rdpmc_fd;
>> -       enum user_read_state old_user_read = USER_READ_UNKNOWN;
>> +       int old_user_read;
>>
>> -       if (enabled == USER_READ_UNKNOWN)
>> +       len = read(fd, buf, sizeof(buf) - 1);
>> +       if (len <= 0) {
>> +               pr_debug("%s read failed\n", __func__);
>>                  return USER_READ_UNKNOWN;
>> +       }
>> +       buf[len] = '\0';
>>
>> -       events_fd = perf_pmu__event_source_devices_fd();
>> -       if (events_fd < 0)
>> +       errno = 0;
>> +       value = strtol(buf, &endptr, 10);
>> +       if (errno || endptr == buf || value < 0 || value > INT_MAX) {
> 
> Given we're range checking the read value, can the upper bound be "> 2" ?
> 

Is there a particular reason to? Similarly to above, I only think this 
will cause issues when new values are added. At the moment the test is 
immune to it.

>> +               pr_debug("%s invalid value: %s\n", __func__, buf);
>>                  return USER_READ_UNKNOWN;
>> +       }
>> +       old_user_read = value;
>>
>> -       rdpmc_fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
>> -       if (rdpmc_fd < 0) {
>> -               close(events_fd);
>> -               return USER_READ_UNKNOWN;
>> +       if (enabled == old_user_read)
>> +               return old_user_read;
>> +
>> +       len = scnprintf(buf, sizeof(buf), "%d\n", enabled);
>> +       if (lseek(fd, 0, SEEK_SET) < 0) {
>> +               pr_debug("%s seek failed\n", __func__);
>> +               return old_user_read;
>>          }
>> +       if (write(fd, buf, len) != len)
>> +               pr_debug("%s write failed\n", __func__);
>>
>> -       len = read(rdpmc_fd, buf, sizeof(buf));
>> -       if (len != sizeof(buf))
>> -               pr_debug("%s read failed\n", __func__);
>> +       return old_user_read;
>> +}
>> +
>> +static int set_user_read(struct perf_pmu *pmu, int enabled)
>> +{
>> +       int events_fd, fd, old_user_read;
>>
>> -       // Note, on Intel hybrid disabling on 1 PMU will implicitly disable on
>> -       // all the core PMUs.
>> -       old_user_read = (buf[0] == '1') ? USER_READ_ENABLED : USER_READ_DISABLED;
>> +       if (enabled == USER_READ_UNKNOWN)
>> +               return USER_READ_UNKNOWN;
>>
>> -       if (enabled != old_user_read) {
>> -               buf[0] = (enabled == USER_READ_ENABLED) ? '1' : '0';
>> -               len = write(rdpmc_fd, buf, sizeof(buf));
>> -               if (len != sizeof(buf))
>> -                       pr_debug("%s write failed\n", __func__);
>> +       events_fd = perf_pmu__event_source_devices_fd();
>> +       if (events_fd >= 0) {
>> +               fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
>> +               if (fd >= 0) {
>> +                       /*
>> +                        * Note, on Intel hybrid disabling on 1 PMU will
>> +                        * implicitly disable on all the core PMUs.
>> +                        */
>> +                       old_user_read = set_user_read_fd(fd, enabled);
>> +                       close(fd);
>> +                       close(events_fd);
>> +                       return old_user_read;
>> +               }
>> +               close(events_fd);
>>          }
>> -       close(rdpmc_fd);
>> -       close(events_fd);
>> +
>> +       /* Fallback: perf_user_access interface (arm64, riscv, or similar) */
>> +       fd = open("/proc/sys/kernel/perf_user_access", O_RDWR);
>> +       if (fd < 0)
>> +               return USER_READ_UNKNOWN;
>> +
>> +       old_user_read = set_user_read_fd(fd, enabled);
>> +       close(fd);
>>          return old_user_read;
>>   }
>>
>> @@ -240,7 +271,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
>>          perf_thread_map__set_pid(threads, 0, 0);
>>
>>          while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
>> -               enum user_read_state saved_user_read_state = set_user_read(pmu, enabled);
>> +               int saved_user_read_state = set_user_read(pmu, enabled);
>>                  struct perf_event_attr attr = {
>>                          .type   = PERF_TYPE_HARDWARE,
>>                          .config = perf_pmus__supports_extended_type()
>> @@ -253,7 +284,8 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
>>                  struct perf_evsel *evsel = NULL;
>>                  int err;
>>                  struct perf_event_mmap_page *pc;
>> -               bool mapped = false, opened = false, rdpmc_supported;
>> +               bool mapped = false, opened = false, rdpmc_expected;
>> +               bool rdpmc_event_active;
>>                  struct perf_counts_values counts = { .val = 0 };
>>
>>
>> @@ -301,26 +333,53 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
>>                          goto cleanup;
>>                  }
>>
>> +               /*
>> +                * When pc->index == 0, userspace access is disabled and Perf
>> +                * will silently use the read() syscall instead. Test this to
>> +                * make sure we're not doing that.
>> +                */
>> +               rdpmc_event_active = pc->index;
>> +
>> +               /*
>> +                * If we couldn't set the state, test that whatever state we're
>> +                * already in is the expected one.
>> +                */
>>                  if (saved_user_read_state == USER_READ_UNKNOWN)
>> -                       rdpmc_supported = pc->cap_user_rdpmc && pc->index;
>> +                       rdpmc_expected = pc->cap_user_rdpmc && rdpmc_event_active;
>>                  else
>> -                       rdpmc_supported = (enabled == USER_READ_ENABLED);
>> +                       rdpmc_expected = (enabled == USER_READ_ENABLED);
>>
>> -               if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index)) {
>> -                       pr_err("User space counter reading for PMU %s [Failed unexpected supported counter access %d %d]\n",
>> -                               pmu->name, pc->cap_user_rdpmc, pc->index);
>> +               if (rdpmc_expected && (!pc->cap_user_rdpmc || !rdpmc_event_active)) {
>> +                       pr_err("User space counter reading for PMU %s [Failed. rdpmc event should be both enabled and active %d %d]\n",
>> +                               pmu->name, pc->cap_user_rdpmc, rdpmc_event_active);
>>                          ret = TEST_FAIL;
>>                          goto cleanup;
>>                  }
>>
>> -               if (!rdpmc_supported && pc->cap_user_rdpmc) {
>> -                       pr_err("User space counter reading for PMU %s [Failed unexpected unsupported counter access %d]\n",
>> -                               pmu->name, pc->cap_user_rdpmc);
>> +#ifdef __aarch64__
>> +               /*
>> +                * On Arm, pc->cap_user_rdpmc is set when the event is opened
>> +                * with userspace counter access, regardless of whether rdpmc is
>> +                * enabled or not via sysfs. The event is always opened with it
>> +                * in this test, so don't check it in the expected disabled
>> +                * case.
>> +                */
> 
> It seems uapi/linux/perf_event.h should be amended with this meaning.
> Currently it says:
> ```
> cap_user_rdpmc          : 1, /* The RDPMC instruction can be used to
> read counts */
> ```
> and that lacks the sysfs nuance particular to ARM.
> 

Do we need to mention sysfs here? The other platforms have the PMU rdpmc 
file which isn't mentioned.

I can change it to this which would apply to all platforms:

/* The RDPMC instruction can be used to read counts if pc->index is set */

The examples in that file already check pc->index, so I suppose there 
isn't really anything Arm specific if it's phrased that way. If 
cap_user_rdpmc was already enough to gate reading, then the examples 
wouldn't have included the pc->index check as well.

>> +               if (!rdpmc_expected && rdpmc_event_active) {
>> +                       pr_err("User space counter reading for PMU %s [Failed. rdpmc event should be inactive %d]\n",
>> +                               pmu->name, rdpmc_event_active);
>> +                       ret = TEST_FAIL;
>> +                       goto cleanup;
>> +               }
>> +#else
>> +               if (!rdpmc_expected && pc->cap_user_rdpmc) {
>> +                       pr_err("User space counter reading for PMU %s [Failed. rdpmc event should be disabled and inactive %d %d]\n",
>> +                               pmu->name, pc->cap_user_rdpmc, rdpmc_event_active);
>>                          ret = TEST_FAIL;
>>                          goto cleanup;
>>                  }
>> +#endif
> 
> So in the general (non-ARM) case should there be two prints? One for
> "disabled" from pc->cap_user_rdpmc and one for "inactive" from
> rdpmc_event_active?

I assumed that myself and tried adding it so it was symmetrical to the 
"expected enabled" case. But there is another platform difference, 
PowerPC seems to set pc->index (rdpmc_event_active) even when the cap is 
disabled. So you have to check both the cap and index are set for the 
enabled case but only check the cap for the disabled case (everywhere 
execpt Arm). I assume that's why index is missing or was removed from 
this test in the first place.

Honestly it is quite a bit of a mess, but I think getting away with only 
one platform conditional and not weakening any of the existing tests is 
quite a good outcome.

> In that case the cap_user_rdpmc can be skipped on
> ARM due to it not adhering to the common behavior.
> 
> Thanks,
> Ian
> 
>>
>> -               if (rdpmc_supported && pc->pmc_width < 32) {
>> +               if (rdpmc_expected && pc->pmc_width < 32) {
>>                          pr_err("User space counter reading for PMU %s [Failed width not set %d]\n",
>>                                  pmu->name, pc->pmc_width);
>>                          ret = TEST_FAIL;
>> @@ -328,7 +387,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
>>                  }
>>
>>                  perf_evsel__read(evsel, 0, 0, &counts);
>> -               if (rdpmc_supported && counts.val == 0) {
>> +               if (rdpmc_expected && counts.val == 0) {
>>                          pr_err("User space counter reading for PMU %s [Failed read]\n", pmu->name);
>>                          ret = TEST_FAIL;
>>                          goto cleanup;
>>
>> ---
>> base-commit: 6ae6fb96ccd48032b00a38d5f8e0e0a2cce4972b
>> change-id: 20260817-rdpmc-detection-logic-d3f7a49cfb46
>>
>> Best regards,
>> --
>> James Clark <james.clark@linaro.org>
>>

