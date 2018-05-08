From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] perf tools: allow map files to specify DSO
Date: Mon, 7 May 2018 17:34:16 -0700
Message-ID: <20180508003416.GG4050@tassilo.jf.intel.com>
References: <1525717456-21475-1-git-send-email-johunt@akamai.com>
 <20180507184001.GE4050@tassilo.jf.intel.com>
 <e6272e7c-25fd-0d2d-4199-fcf3ec604546@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e6272e7c-25fd-0d2d-4199-fcf3ec604546@akamai.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Hunt <johunt@akamai.com>
Cc: mingo@redhat.com, acme@kernel.org, peterz@infradead.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com, kirill.shutemov@linux.intel.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, May 07, 2018 at 02:30:32PM -0700, Josh Hunt wrote:
> On 05/07/2018 11:40 AM, Andi Kleen wrote:
> > On Mon, May 07, 2018 at 02:24:16PM -0400, Josh Hunt wrote:
> > > Add the ability to specify a DSO in the /tmp/perf-<PID>.map file.
> > > The DSO should be the first line in the file and readable by the
> > > running user. If a valid DSO is found all other contents of the
> > > file will be ignored. This allows things like callchain unwinding
> > > with DWARF to work.
> > 
> > FWIW it's ok, but also obsolete with Kirill's large-pages-in-tmpfs
> > work in newer kernels. With that you can just copy the executable into
> > a 2MB tmpfs and disable the manual huge page copying and everything
> > should work as usually.
> > 
> > So essentially it's only a hack for old kernels and old binaries.
> > 
> > But doesn't hurt I guess.
> 
> Ah, very interesting. I wasn't aware of this. Can you point me to some more
> details on this process?

See commit 5a6e75f8110c97e2a5488894d4e922187e6cb343

-Andi
