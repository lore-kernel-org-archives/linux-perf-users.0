From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH RFC 0/3] btrfs: Performance profiler support
Date: Thu, 7 Mar 2019 17:12:05 +0100
Message-ID: <20190307161203.GJ31119@twin.jikos.cz>
References: <20190306061907.29685-1-wqu@suse.com>
 <20190307140223.GH31119@twin.jikos.cz>
 <ccf67c41-752a-6812-0de7-34f39c37ecac@gmx.com>
Reply-To: dsterba@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-btrfs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ccf67c41-752a-6812-0de7-34f39c37ecac@gmx.com>
Sender: linux-btrfs-owner@vger.kernel.org
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Thu, Mar 07, 2019 at 10:18:49PM +0800, Qu Wenruo wrote:
> > Well, most of that is answered by 'figure out how to use tracepoints and
> > perf for that'.
> > 
> > If there were not a whole substystem, actively maintained and
> > documented, implementing something like that might help, but that's not
> > the case.
> > 
> > I see what you were able to understand from the results, but it's more
> > like a custom analysis tool that should not merged as-is. It brings a
> > whole new interface and that's always hard to get right with all the
> > mistakes ahead that somebody has probably solved already.
> > 
> > It would be good to have list of the limitations of perf you see, and we
> > can find a solution ourselves or ask elsewhere.
> 
> Add linux-perf-users mail list.
> 
> I should mention the problem of ftrace (or my perf skill) in cover letter.
> 
> The biggest problem is the conflicts between detailed function execution
> duration and classification.
> 
> For tree lock case, indeed we can use function graph to get execution
> duration of btrfs_tree_read_lock() and btrfs_tree_lock().
> But that's all. We can't really do much classification.
> 
> If just use trace event, with trace event added, then we can't get the
> execution duration.

I think you can save the start and end times and put the delta to the
tracepoint output.
