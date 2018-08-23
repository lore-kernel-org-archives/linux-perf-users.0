From: =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Subject: Re: [PATCH] AMD perf PMU events for AMD Family 17h.
Date: Thu, 23 Aug 2018 13:21:45 +0200
Message-ID: <fc049074-595e-92d7-5bab-bcd00f8493e2@suse.cz>
References: <3ee15066-429e-b0f2-1255-aab100fad472@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ee15066-429e-b0f2-1255-aab100fad472@suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Cc: Martin Jambor <mjambor@suse.cz>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

May I please ping this.

Thanks,
Martin

On 08/06/2018 10:42 AM, Martin Liška wrote:
> Hello.
> 
> Following patch adds PMC events for AMD Family 17 CPUs as defined in [1].
> It covers events described in section: 2.1.13. Regex pattern in mapfile.csv
> covers all CPUs of the family.
> 
> Thanks,
> Martin
> 
> [1] https://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf
> 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> 
> ---
>  .../pmu-events/arch/x86/amdfam17h/cache.json  | 332 ++++++++++++++++++
>  .../pmu-events/arch/x86/amdfam17h/core.json   | 124 +++++++
>  .../arch/x86/amdfam17h/floating-point.json    | 196 +++++++++++
>  .../pmu-events/arch/x86/amdfam17h/memory.json | 225 ++++++++++++
>  .../pmu-events/arch/x86/amdfam17h/other.json  |  51 +++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
>  6 files changed, 929 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/core.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/other.json
> 
> 
