From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v7 3/5] powerpc/hv-24x7: Add sysfs files inside hv-24x7 device to show processor details
Date: Wed, 29 Apr 2020 21:33:21 +1000
Message-ID: <87a72ufrwe.fsf@mpe.ellerman.id.au>
References: <20200327063642.26175-1-kjain@linux.ibm.com> <20200327063642.26175-4-kjain@linux.ibm.com> <87d07qfrxb.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87d07qfrxb.fsf@mpe.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com, alexander.shishkin@linux.intel.com, mingo@kernel.org, paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com, gregkh@linuxfoundation.org, benh@kernel.crashing.org, mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com, tglx@linutronix.de, kjain@linux.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Kajol Jain <kjain@linux.ibm.com> writes:
>> To expose the system dependent parameter like total number of
>> sockets and numbers of chips per socket, patch adds two sysfs files.
>> "sockets" and "chips" are added to /sys/devices/hv_24x7/interface/
>> of the "hv_24x7" pmu.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>  arch/powerpc/perf/hv-24x7.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>
> This should also add documentation under Documentation/ABI.

Ugh, sorry, you do that in the next patch :}

cheers
