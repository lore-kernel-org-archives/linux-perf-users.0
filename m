From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 15/15] tools headers: Synchronize linux/bits.h with the
 kernel sources
Date: Mon, 20 Apr 2020 12:19:36 +0100
Message-ID: <96ec5885-6f6a-288b-475d-99556113f95e@arm.com>
References: <20200414164854.26026-1-acme@kernel.org>
 <20200414164854.26026-16-acme@kernel.org>
 <7951882d-d13a-7b1e-36f4-73c188015161@arm.com>
 <20200416155404.GE2650@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200416155404.GE2650@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Rikard Falkeborn <rikard.falkeborn@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

On 4/16/20 4:54 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 15, 2020 at 10:14:06AM +0100, Vincenzo Frascino escreveu:
>> On 4/14/20 5:48 PM, Arnaldo Carvalho de Melo wrote:
>>> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>
>>> To pick up the changes in these csets:
>>>
>>>   295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
>>>   3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO")
>>>
>>> To address this tools/perf build warning:
>>>
>>>   Warning: Kernel ABI header at 'tools/include/linux/bits.h' differs from latest version at 'include/linux/bits.h'
>>>   diff -u tools/include/linux/bits.h include/linux/bits.h
>>>
>>> This clashes with usage of userspace's static_assert(), that, at least
>>> on glibc, is guarded by a ifnded/endif pair, do the same to our copy of
>>> build_bug.h and avoid that diff in check_headers.sh so that we continue
>>> checking for drifts with the kernel sources master copy.
>>>
>>> This will all be tested with the set of build containers that includes
>>> uCLibc, musl libc, lots of glibc versions in lots of distros and cross
>>> build environments.
>>>
>>> The tools/objtool, tools/bpf, etc were tested as well.
>>>
>>
>> Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com> # vDSO parts
> 
> Hey, thanks a lot for checking it! :-)
>

No issue :-) Thank you for updating the tools headers!

[...]

-- 
Regards,
Vincenzo
