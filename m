From: Hongxu Jia <hongxu.jia@windriver.com>
Subject: Re: [PATCH V2] perf arm64: Fix generate system call table failed with
 /tmp mounted with noexec
Date: Fri, 19 Oct 2018 23:36:54 +0800
Message-ID: <68f6a3b7-9dfe-3ed0-7582-5fc923b2d56b@windriver.com>
References: <1c6964d0-a7d2-83ef-16f2-bdf349e3f0af@gydle.com>
 <1539915379-11910-1-git-send-email-hongxu.jia@windriver.com>
 <9da3ccbf-ec36-c676-7472-fe7d642cd7e0@gydle.com>
 <20181019153000.GC5565@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019153000.GC5565@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@redhat.com>, =?UTF-8?Q?S=c3=a9bastien_Boisvert?= <sboisvert@gydle.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kim.phillips@arm.com, brueckner@linux.ibm.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, mpe@ellerman.id.au, peterz@infradead.org, ravi.bangoria@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com, namhyung@kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 2018/10/19 下午11:30, Arnaldo Carvalho de Melo wrote:
> Exactly.
>
> So, to move forward, just send a new patch specifically for this part,
> i.e. the removal of the harmless but unneeded extra slash, the other
> part I already took care of.

Got it, I will send a new patch for the removal of the harmless

Thank a huge for all your guys to help me to improve commit message.

//Hongxu


>
> - Arnaldo
>   
