From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 11/16] tools headers x86: Sync asm/cpufeatures.h copy with
 the kernel sources
Date: Sat, 5 Jan 2019 17:06:28 +0100
Message-ID: <e5aa2047-8d72-70a4-63bc-74d9cef62962@redhat.com>
References: <20190104183337.12771-1-acme@kernel.org>
 <20190104183337.12771-12-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104183337.12771-12-acme@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Robert Hoo <robert.hu@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>
List-Id: linux-perf-users.vger.kernel.org

On 04/01/19 19:33, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> To get the changes from:
> 
>   a0aea130afeb ("KVM: x86: Add CPUID support for new instruction WBNOINVD")

Slightly better commit:

    08e823c2c589 ("x86/cpufeatures: Add WBNOINVD feature definition")

Otherwise looks good.

Paolo
