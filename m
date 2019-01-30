From: Andi Kleen <ak@linux.intel.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
Date: Wed, 30 Jan 2019 12:39:47 -0800
Message-ID: <87zhrhzxpo.fsf@linux.intel.com>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
        <20190130183648.GA24233@krava>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130183648.GA24233@krava> (Jiri Olsa's message of "Wed, 30
        Jan 2019 19:36:48 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, eranian@google.com, vincent.weaver@maine.edu, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Jiri Olsa <jolsa@redhat.com> writes:
>
> the patch adds check_eriod pmu callback.. I need to check if there's
> better way to do this, but so far it fixes the crash for me
>
> if you guys could check this patch, that'd be great

There's already a limit_period callback, perhaps that could
be extended. But ok, can do it this way too.

I suspect there are some other cases that need this callback, not
just BTS, e.g. the checks in hsw_hw_config


-Andi
